From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/2] fix expression type for floating point !
Date: Mon, 27 May 2013 01:09:04 -0700
Message-ID: <20130527080903.GB2872@gmail.com>
References: <1369402236-16871-1-git-send-email-xi.wang@gmail.com>
 <1369402236-16871-2-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pb0-f50.google.com ([209.85.160.50]:44872 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756769Ab3E0IJQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 May 2013 04:09:16 -0400
Received: by mail-pb0-f50.google.com with SMTP id wy17so6539381pbc.37
        for <linux-sparse@vger.kernel.org>; Mon, 27 May 2013 01:09:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1369402236-16871-2-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Xi Wang <xi.wang@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Fri, May 24, 2013 at 09:30:36AM -0400, Xi Wang wrote:
> 
> The expression type of zero testing should be EXPR_COMPARE, rather than
> EXPR_BINOP, which causes bad_op.
> 
> Signed-off-by: Xi Wang <xi.wang@gmail.com>

Acked-By: Christopher Li <sparse@chrisli.org>

