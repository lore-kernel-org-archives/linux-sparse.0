From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse ignores __attribute__((packed))
Date: Mon, 16 Aug 2010 17:20:16 -0700
Message-ID: <AANLkTi=M4E5ecu_d_w8aZV_270k7Xc6w6BtXD8w2A-zX@mail.gmail.com>
References: <AANLkTi=1-hMnZGHix_DC_7_7TcOCo6OrGJx3JYFppN86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43752 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753957Ab0HQAUR (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 16 Aug 2010 20:20:17 -0400
Received: by eyg5 with SMTP id 5so1675992eyg.19
        for <linux-sparse@vger.kernel.org>; Mon, 16 Aug 2010 17:20:16 -0700 (PDT)
In-Reply-To: <AANLkTi=1-hMnZGHix_DC_7_7TcOCo6OrGJx3JYFppN86@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-sparse@vger.kernel.org

On Sun, Aug 15, 2010 at 9:15 AM, Bart Van Assche <bvanassche@acm.org> wrote:
> Hello,
>
> The test program below compiles fine with gcc 4.5.0 but triggers a
> build error with sparse (git repository last updated on July 11). This
> seems like a sparse bug to me. Is this a known issue ?

Yes, it is a known issue. Sparse hasn't pay attention to the packed
attribute at all.

Patches are welcome :-)

Chris
