package jsearchdemo;

import search.*;

public interface StateListener 
{

    void queueChanged(Algorithm a);

    void stateChanged();
}
