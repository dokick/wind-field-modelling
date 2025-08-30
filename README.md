# wind-field-modelling

## How to generate a plot of the flight path

1. Run a main simulation, e.g. the full simulation or the test case for all the models ```tests/model_main_test.slx```
    - If you choose "model_main_test.slx", make sure to run the init script for that test case, see ```tests/model_main_test_init.m```
2. Restore the ```SAMPLE_TIME``` in all base models. In order for a main simulation to work, the sample time in the model configuration is set to ```auto```. These need to be restored, so these models can run independent.
3. Run ```scripts/plot_path.m```. If desired, one can also run the three sections separately. The second and the third section will require a lot of computing time depending on the flight duration.
4. (Optional, but recommended) Override the ```SAMPLE_TIME``` with ```auto```, so future runs of a main simulation properly work again.

## How to generate a plot of a singular instance of a model

1. Run the init script of the according base model, e.g. for the sinusoidal gust: ```tests/model_sinusoidal_gust_test_init.m```
2. Restore the ```SAMPLE_TIME``` in the base model. In order for a main simulation to work, the sample time in the model configuration is set to ```auto```. This needs to be restored, so the base model can run independent.
3. Run the base model, e.g. for a sinusoidal gust ```tests/model_sinusoidal_gust_test.slx```
4. Run the according plot script, e.g. for a sinusoidal gust ```tests/model_sinusoidal_gust_plot.m```
5. (Optional, but recommended) Override the ```SAMPLE_TIME``` with ```auto```, so future runs of a main simulation properly work again.