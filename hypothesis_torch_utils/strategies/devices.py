import torch
from hypothesis import settings
from hypothesis import strategies as st

torch_devices: st.SearchStrategy[torch.device]
if "_cpu" in settings._current_profile:  # type: ignore
    torch_devices = st.just(torch.device("cpu"))
else:
    # We only want exclusively the CPU when _cpu is in the profile name
    want_gpu: bool = "_cpu" not in settings._current_profile  # type: ignore
    have_gpu: bool = torch.cuda.is_available()

    if want_gpu and have_gpu:
        torch_devices = st.sampled_from([torch.device("cpu"), torch.device("cuda:0")])
    elif want_gpu and not have_gpu:
        print("No GPU available, falling back to CPU")
        torch_devices = st.just(torch.device("cpu"))
    else:
        torch_devices = st.just(torch.device("cpu"))
