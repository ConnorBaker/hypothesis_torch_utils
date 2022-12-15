from typing import TypedDict

import torch
from hypothesis import strategies as st

from hypothesis_torch_utils.strategies.devices import torch_devices
from hypothesis_torch_utils.strategies.dtypes import torch_real_dtypes


class DeviceAndDType(TypedDict):
    device: torch.device
    dtype: torch.dtype


# Checks for consistency with device and dtype selection
@st.composite
def devices_and_dtypes(
    draw: st.DrawFn,
    *,
    device: None | str | torch.device | st.SearchStrategy[torch.device] = None,
    dtype: None | torch.dtype | st.SearchStrategy[torch.dtype] = None,
) -> DeviceAndDType:
    if device is None:
        device = draw(torch_devices)
    elif isinstance(device, str):
        device = torch.device(device)
    elif isinstance(device, st.SearchStrategy):
        device = draw(device)

    assert isinstance(device, torch.device)

    if dtype is None:
        dtype_strat = torch_real_dtypes
    elif isinstance(dtype, torch.dtype):
        dtype_strat = st.just(dtype)
    else:
        dtype_strat = dtype

    # Filter out unsupported dtypes
    if device.type == "cpu":
        # Most CPUs don't support float16
        dtype_strat = dtype_strat.filter(lambda t: t != torch.float16)

    dtype = draw(dtype_strat)

    return DeviceAndDType(device=device, dtype=dtype)
