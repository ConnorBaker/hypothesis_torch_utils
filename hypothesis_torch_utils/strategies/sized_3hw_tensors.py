import torch
from hypothesis import settings
from hypothesis import strategies as st

from hypothesis_torch_utils.strategies.chw_tensors import CHWShape, chw_tensors
from hypothesis_torch_utils.strategies.dtypes import torch_float_dtypes

_shape_strat_scaling_factor: int = 4 if settings._current_profile == "ci" else 1  # type: ignore
# Ensure all images have a height and width divisible by four
sized_3hw_shapes: st.SearchStrategy[CHWShape] = (
    st.tuples(
        st.just(3),
        st.integers(32, _shape_strat_scaling_factor * 256),
        st.integers(32, _shape_strat_scaling_factor * 256),
    )
    .filter(lambda t: t[-2] % 4 == 0 and t[-1] % 4 == 0)
    .map(CHWShape)
)


def sized_3hw_tensors(
    shape: CHWShape | st.SearchStrategy[CHWShape] = sized_3hw_shapes,
    dtype: torch.dtype | st.SearchStrategy[torch.dtype] = torch_float_dtypes,
    device: None | str | torch.device | st.SearchStrategy[torch.device] = None,
) -> st.SearchStrategy[torch.Tensor]:
    """
    Returns a strategy for generating 3HW tensors. Useful for testing image processing.

    Args:
        shape: The shape of the tensor.
        dtype: The dtype of the tensor.
        device: The device of the tensor. If None, it will be sampled.

    Returns:
        A strategy for generating 3HW tensors.
    """
    return chw_tensors(shape=shape, dtype=dtype, device=device)
