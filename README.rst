Calculating Possible Bandwidth in by Link Speed
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

How to calculate what the possible bandwidth is for a specific Network Interface.

There are two different versions of the script that are in this repository. One will calculate possible bandwidth based on average days in a month, and the other will calculate possible bandwidth based on a specified amount of hours. This simple BASH script that will do all of the calculations for you, including assisting you with an estimation of error.

Once you have the script, you will have to make it executable:

.. code-block:: bash

    chmod +x bdcalc.sh

.. code-block:: bash

    chmod +x bdhcalc.sh

Now you simply run it

.. code-block:: bash

    ./bdcalc.sh  

You can specify the network interface from the command line, which avoids the interactivity :

.. code-block:: bash

    ./bdcalc.sh 10

You can also specify the network interface and hours active from the command line, which avoids the interactivity :

.. code-block:: bash

    ./bdhcalc.sh 10 24

--------

Drop me a line if you have questions.
