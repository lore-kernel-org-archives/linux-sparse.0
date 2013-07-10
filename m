From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: mlx5: Add driver for Mellanox Connect-IB adapters
Date: Wed, 10 Jul 2013 13:54:15 +0300
Message-ID: <20130710105415.GA31232@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:49647 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754320Ab3GJK4n (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Jul 2013 06:56:43 -0400
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: eli@mellanox.com
Cc: linux-rdma@vger.kernel.org, linux-sparse@vger.kernel.org

---
Side note: Sparse should warn about endian bugs but in linux-next
endian checking is disabled because we hit:

include/uapi/linux/swab.h:71:16: error: undefined identifier '__builtin_bswap64'
include/uapi/linux/swab.h:71:33: error: not a function <noident>

do_error() in Sparse disables warning messages.  I feel like we
shouldn't do that.

        /* Shut up warnings after an error */
        max_warnings = 0;
---

Hello Eli Cohen,

The patch e126ba97dba9: "mlx5: Add driver for Mellanox Connect-IB 
adapters" from Jul 7, 2013, has an endian related bug:

drivers/net/ethernet/mellanox/mlx5/core/main.c
   214          memset(&set_out, 0, sizeof(set_out));
   215          set_ctx->hca_cap.uar_page_sz = cpu_to_be16(PAGE_SHIFT - 12);
                         ^^^^^^^^^^^^^^^^^^^
This is defined in the header as be32 but we are saving a be16 to it.
My guess is the header is correct and the be16 is wrong.

   216          set_ctx->hdr.opcode = cpu_to_be16(MLX5_CMD_OP_SET_HCA_CAP);
   217          err = mlx5_cmd_exec(dev, set_ctx, sizeof(*set_ctx),
   218                                   &set_out, sizeof(set_out));

regards,
dan carpenter

