package search;

import java.util.Iterator;
import java.util.List;
import java.util.LinkedList;

public abstract class Graph
{
    public abstract Node getStartNode();
    public abstract Node getGoalNode();
    public abstract List getOutgoingEdges(Node n);

    /**
     * Retrieves the children of the given node.
     *
     * @param n The node to retrieve the children from. Cannot be 
     *           <tt>null</tt>
     * @return The list of children nodes.
     */
    public List getChildren(Node n) {
        //assert n != null;

        LinkedList l = new LinkedList();

        for (Iterator it = getOutgoingEdges(n).iterator(); it.hasNext(); ) {
            Edge e = (Edge) it.next();
            if (e.getEndNode().equals(n)) 
                l.add(e.getBeginNode());
            else 
                l.add(e.getEndNode());
        }

        return l;
    }
}
