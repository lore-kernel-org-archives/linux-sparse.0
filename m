From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: False positives unlock warning
Date: Wed, 14 Jan 2015 19:41:27 +0300
Message-ID: <20150114164127.GD5520@mwanda>
References: <1421243218.2542.45.camel@hadess.net>
 <20150114141143.GH5571@mwanda>
 <1421245172.2542.50.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:19435 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbbANQlh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 14 Jan 2015 11:41:37 -0500
Content-Disposition: inline
In-Reply-To: <1421245172.2542.50.camel@hadess.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-sparse@vger.kernel.org

Sparse gets confused because of the unused "_success_exit:" label.  If
you delete that it should go away.  In "real" kernel code GCC will warn
about unused labels.

I created a more minimal test case while I was looking at this, if
anyone is interested.

static int foo;

int recv_indicatepkt_reorder(_adapter *padapter, union recv_frame *prframe)
{
        struct rx_pkt_attrib *pattrib = &prframe->u.hdr.attrib;
        struct recv_reorder_ctrl *preorder_ctrl = prframe->u.hdr.preorder_ctrl;
        _queue *ppending_recvframe_queue = &preorder_ctrl->pending_recvframe_queue;

        spin_lock(&ppending_recvframe_queue->lock);
        if (foo)
                goto err;
        spin_unlock(&ppending_recvframe_queue->lock);

unused_label:
        return 0;
err:
        spin_unlock(&ppending_recvframe_queue->lock);
        return -1;
}

regards,
dan carpenter
