From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Fix size calculation of unsized bool array
Date: Fri, 5 Feb 2016 00:10:15 +0800
Message-ID: <CANeU7Q=bsRJP_7NtiDh9Lhda1yqcnYPLjH4VP-S9QW2sFMAS1w@mail.gmail.com>
References: <1452131229-29756-1-git-send-email-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:34719 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbcBDQKQ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 4 Feb 2016 11:10:16 -0500
Received: by mail-io0-f175.google.com with SMTP id 9so98173784iom.1
        for <linux-sparse@vger.kernel.org>; Thu, 04 Feb 2016 08:10:15 -0800 (PST)
In-Reply-To: <1452131229-29756-1-git-send-email-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jan 7, 2016 at 9:47 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> This stops sparse from issuing the error message
>         "error: cannot size expression"
> for code like:
>         static _Bool boolarray[] = {
>                 0,
>                 1,
>         };
>         static int n = sizeof(boolarray);

This patch looks great. Applied.

Chris
