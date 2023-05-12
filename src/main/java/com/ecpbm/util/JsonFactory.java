//package com.ecpbm.util;
//
//import com.ecpbm.pojo.TreeNode;
//
//import java.util.ArrayList;
//import java.util.List;
//
//public class JsonFactory {
//    public static List<TreeNode> buildtree(List<TreeNode> nodes,int id){
//        List<TreeNode> treeNodes=new ArrayList<TreeNode>();
//
//        for(TreeNode treeNode:nodes){
//            TreeNode node = new TreeNode();
//            node.setId(treeNode.getId());
//            node.setFid(treeNode.getFid());
//            node.setText(treeNode.getText());
//            if(id==treeNode.getFid()){
//                node.setChildren(buildtree(nodes,node.getId()));
//                treeNodes.add(node);
//            }
//        }
//        return treeNodes;
//    }
//
//}
package com.ecpbm.util;

import java.util.ArrayList;
import java.util.List;

import com.ecpbm.pojo.TreeNode;


public class JsonFactory {
    public static List<TreeNode> buildtree(List<TreeNode> nodes, int id) {
        List<TreeNode> treeNodes = new ArrayList<>();
        //此处就是循环里面出现递归的现象，
        //每次如果符合if条件,则执行递归，当一次递归执行完成后，才能return，然后执行上一步递归，
        //需要注意的是，没此递归结束的情况必须是将for循环执行完成后也不满足if条件才能return，到上一步递归

        for (TreeNode treeNode : nodes) {
            TreeNode node = new TreeNode();
            node.setId(treeNode.getId());
            node.setText(treeNode.getText());
            if (id == treeNode.getFid()) {
                // 递给调用buildtree方法给TreeNode中的children属性赋值
                node.setChildren(buildtree(nodes, node.getId()));//buildtree的返回值是Lsit<TreeNode>
                treeNodes.add(node);
            }
        }
        return treeNodes;//每次递归返回都是重node.setChildren()开始
    }
}