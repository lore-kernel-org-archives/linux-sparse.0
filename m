From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/5] Fix an "'__sentinel__' attribute directive ignored"
	warning
Date: Mon, 20 Jul 2009 13:18:43 -0700
Message-ID: <70318cbf0907201318s199fb9c4sc51d249461d18a57@mail.gmail.com>
References: <4A62329B.9040107@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f202.google.com ([209.85.212.202]:46383 "EHLO
	mail-vw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbZGTUSo (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 20 Jul 2009 16:18:44 -0400
Received: by vwj40 with SMTP id 40so408045vwj.33
        for <linux-sparse@vger.kernel.org>; Mon, 20 Jul 2009 13:18:43 -0700 (PDT)
In-Reply-To: <4A62329B.9040107@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Sat, Jul 18, 2009 at 1:37 PM, Ramsay Jones<ramsay@ramsay1.demon.co.uk> wrote:
>
> This attribute was introduced in gcc 3.5. In order to avoid
> such warnings, add a gcc version check when defining the
> SENTINEL_ATTR macro. (This warning message, in particular,
> was issued by a gcc 3.4.4 compiler).

Can you elaborate the error message you received?
A small test program would be great.

Thanks

Chris
