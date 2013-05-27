From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [PATCH 2/2] fix expression type for floating point !
Date: Mon, 27 May 2013 14:13:25 +0300
Message-ID: <CAOJsxLGqvQVW+4hwKdmZr-JQ+CO3rwfKRWH4KnEE1j9tLDSTuw@mail.gmail.com>
References: <1369402236-16871-1-git-send-email-xi.wang@gmail.com>
	<1369402236-16871-2-git-send-email-xi.wang@gmail.com>
	<20130527080903.GB2872@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:56857 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757669Ab3E0LN0 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 27 May 2013 07:13:26 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so1437691wgh.6
        for <linux-sparse@vger.kernel.org>; Mon, 27 May 2013 04:13:25 -0700 (PDT)
In-Reply-To: <20130527080903.GB2872@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Xi Wang <xi.wang@gmail.com>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Fri, May 24, 2013 at 09:30:36AM -0400, Xi Wang wrote:
>>
>> The expression type of zero testing should be EXPR_COMPARE, rather than
>> EXPR_BINOP, which causes bad_op.
>>
>> Signed-off-by: Xi Wang <xi.wang@gmail.com>

On Mon, May 27, 2013 at 11:09 AM, Christopher Li <sparse@chrisli.org> wrote:
> Acked-By: Christopher Li <sparse@chrisli.org>

I'll pick this up as well.
