class Solution {
    private int maxProfitHelper(int[] prices,int index,int sell,int transactions, int k, Integer[][][] memo){
        if(transactions>=k){
            return 0;
        }
        if(index==prices.length){
            return 0;
        }
        int take=0,notTake=0;
        int profit = 0;
        
        if( memo[index][sell][transactions] != null)
            return memo[index][sell][transactions];
        if(sell == 1){
            take = -prices[index]+maxProfitHelper(prices, index+1, 0, transactions,k,memo );
            notTake = 0+maxProfitHelper(prices,index+1,1,transactions,k,memo);
            profit = Math.max(take,notTake);
        }
        else{
            take = prices[index]+maxProfitHelper(prices,index+1,1,transactions+1,k, memo);
            notTake = 0+maxProfitHelper(prices, index+1, 0, transactions,k,memo);
            profit = Math.max(take,notTake);
        }
        return memo[index][sell][transactions] = profit;
    }
    public int maxProfit(int k, int[] prices) {
        Integer[][][] memo = new Integer[prices.length][2][k];
        return maxProfitHelper(prices,0,1,0,k,memo);
    }
}
