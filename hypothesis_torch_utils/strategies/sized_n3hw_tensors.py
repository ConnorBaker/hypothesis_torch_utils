import torch
from hypothesis import settings
from hypothesis import strategies as st

from hypothesis_torch_utils.strategies.dtypes import torch_float_dtypes
from hypothesis_torch_utils.strategies.nchw_tensors import NCHWShape, nchw_tensors

_shape_strat_scaling_factor: int = 4 if settings._current_profile == "ci" else 1  # type: ignore
# Ensure all images have a height and width divisible by four
sized_n3hw_shapes: st.SearchStrategy[NCHWShape] = (
    st.tuples(
        st.integers(1, _shape_strat_scaling_factor * 16),
        st.just(3),
        st.integers(32, _shape_strat_scaling_factor * 256),
        st.integers(32, _shape_strat_scaling_factor * 256),
    )
    .filter(lambda t: t[-2] % 4 == 0 and t[-1] % 4 == 0)
    .map(NCHWShape)
)


def sized_n3hw_tensors(
    shape: NCHWShape | st.SearchStrategy[NCHWShape] = sized_n3hw_shapes,
    dtype: torch.dtype | st.SearchStrategy[torch.dtype] = torch_float_dtypes,
    device: None | str | torch.device | st.SearchStrategy[torch.device] = None,
    memory_format: None | torch.memory_format | st.SearchStrategy[torch.memory_format] = None,
) -> st.SearchStrategy[torch.Tensor]:
    """
    Returns a strategy for generating N3HW tensors. Useful for testing image processing.

    Args:
        shape: The shape of the tensor.
        dtype: The dtype of the tensor.
        device: The device of the tensor. If None, it will be sampled.
        memory_format: The memory format of the tensor. If None, it will be sampled.

    Returns:
        A strategy for generating N3HW tensors.
    """
    return nchw_tensors(shape=shape, dtype=dtype, device=device, memory_format=memory_format)
