From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 02/10] sparse: add 'gnu_inline' to the ignored attributes
Date: Thu, 7 Aug 2014 11:25:51 -0700
Message-ID: <CANeU7Q=HG+ZrVrNEGikYLPDOK0LfsfDzSfNcE5MOLnmfxkFGwA@mail.gmail.com>
References: <53DFD206.20002@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:60943 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbaHGSZw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 7 Aug 2014 14:25:52 -0400
Received: by mail-qa0-f51.google.com with SMTP id k15so4363180qaq.24
        for <linux-sparse@vger.kernel.org>; Thu, 07 Aug 2014 11:25:51 -0700 (PDT)
In-Reply-To: <53DFD206.20002@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Mon, Aug 4, 2014 at 11:33 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
>
> Add some more ignored attributes which are used in glibc header files,
> along with a simple test case which includes all three inline attributes
> (__gnu_inline__, __always_inline__ and __noinline__).

This change looks good.

Chris
