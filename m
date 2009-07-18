From: Christopher Li <sparse@chrisli.org>
Subject: Re: Multiple translation unit regression
Date: Sat, 18 Jul 2009 14:53:01 -0700
Message-ID: <70318cbf0907181453u1af5a96ie85fc4d47af8db14@mail.gmail.com>
References: <4A5131F4.7070007@ramsay1.demon.co.uk>
	 <70318cbf0907060232j7067f7fcra857b71ebdf62348@mail.gmail.com>
	 <70318cbf0907062327u51a4253fub2c0f1b2f64c1a@mail.gmail.com>
	 <4A54F452.8030601@ramsay1.demon.co.uk>
	 <70318cbf0907081315w1e066a1fiac24b1b58ef146bb@mail.gmail.com>
	 <4A57AA66.4080305@ramsay1.demon.co.uk>
	 <70318cbf0907101627w1b9760a4oc7d13969751e3d00@mail.gmail.com>
	 <4A5B7257.9090409@ramsay1.demon.co.uk>
	 <4A622FEF.2010704@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:34059 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764AbZGRVxC (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 18 Jul 2009 17:53:02 -0400
Received: by wf-out-1314.google.com with SMTP id 26so490124wfd.4
        for <linux-sparse@vger.kernel.org>; Sat, 18 Jul 2009 14:53:01 -0700 (PDT)
In-Reply-To: <4A622FEF.2010704@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Jul 18, 2009 at 1:26 PM, Ramsay Jones<ramsay@ramsay1.demon.co.uk> wrote:
>
> BTW, I forgot to mention that I changed the test file so that
> it would fail before applying the rest of this patch, and
> pass afterward.
>
> I've attached the new file. The diff is as follows:

Thanks. Will apply that.

Chris
