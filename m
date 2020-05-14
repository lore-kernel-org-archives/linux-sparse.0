From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: complain about re-declared functions with different modifiers
Date: Thu, 14 May 2020 17:04:51 +0300
Message-ID: <20200514140451.GD2078@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:39500 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgENOFB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 14 May 2020 10:05:01 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EE2UGU129454
        for <linux-sparse@vger.kernel.org>; Thu, 14 May 2020 14:05:00 GMT
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 3100yg2rfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-sparse@vger.kernel.org>; Thu, 14 May 2020 14:05:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EE46PV040695
        for <linux-sparse@vger.kernel.org>; Thu, 14 May 2020 14:04:59 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 3100ycqm3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-sparse@vger.kernel.org>; Thu, 14 May 2020 14:04:59 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04EE4wxr031461
        for <linux-sparse@vger.kernel.org>; Thu, 14 May 2020 14:04:58 GMT
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

I recently spent some time tracking down why Smatch wasn't parsing
nvme_put_ctrl() correctly.  It turned out the problem is that it's
declared as both inline and not inline so Smatch never parses it.

drivers/nvme/host/nvme.h
   472  static inline void nvme_get_ctrl(struct nvme_ctrl *ctrl)
   473  {
   474          get_device(ctrl->device);
   475  }
   476  
   477  static inline void nvme_put_ctrl(struct nvme_ctrl *ctrl)
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
It's an inline here.

   478  {
   479          put_device(ctrl->device);
   480  }
   481  
   482  static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
   483  {
   484          return !qid && command_id >= NVME_AQ_BLK_MQ_DEPTH;
   485  }
   486  
   487  void nvme_complete_rq(struct request *req);
   488  bool nvme_cancel_request(struct request *req, void *data, bool reserved);
   489  bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
   490                  enum nvme_ctrl_state new_state);
   491  bool nvme_wait_reset(struct nvme_ctrl *ctrl);
   492  int nvme_disable_ctrl(struct nvme_ctrl *ctrl);
   493  int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
   494  int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
   495  int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
   496                  const struct nvme_ctrl_ops *ops, unsigned long quirks);
   497  void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
   498  void nvme_start_ctrl(struct nvme_ctrl *ctrl);
   499  void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
   500  void nvme_put_ctrl(struct nvme_ctrl *ctrl);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
But then it's re-declared as not inline.

   501  int nvme_init_identify(struct nvme_ctrl *ctrl);

Could Sparse print a warning for that?

regards,
dan carpenter
