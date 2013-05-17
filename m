From: Xi Wang <xi.wang@gmail.com>
Subject: Re: [PATCH] fix floating point ! type
Date: Fri, 17 May 2013 17:52:47 -0400
Message-ID: <CAKU6vybHWHHfQF8HgHnp8Qd5tpBGMRozrbt6actvbXmANXeLKA@mail.gmail.com>
References: <1368737773-6559-1-git-send-email-xi.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:49824 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757402Ab3EQVx2 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 17 May 2013 17:53:28 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp18so5209291obc.21
        for <linux-sparse@vger.kernel.org>; Fri, 17 May 2013 14:53:27 -0700 (PDT)
In-Reply-To: <1368737773-6559-1-git-send-email-xi.wang@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sparse Mailing-list <linux-sparse@vger.kernel.org>
Cc: Christopher Li <sparse@chrisli.org>, Xi Wang <xi.wang@gmail.com>

On Thu, May 16, 2013 at 4:56 PM, Xi Wang <xi.wang@gmail.com> wrote:
> The expression type of zero testing should be EXPR_COMPARE, rather
> than EXPR_BINOP.

There might be a bigger problem.  The C standard says the result type
of comparisons, !, &&, || should be int, rather than bool.
