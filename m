From: Christopher Li <sparse@chrisli.org>
Subject: Re: __attribute__((force)) should not be a storage class
Date: Thu, 27 Feb 2014 13:00:47 -0800
Message-ID: <CANeU7QkjEUOZ-0m7nLjqAoMx4WJnoBdzhM1Ef3Y=RN+ewPSBMA@mail.gmail.com>
References: <20140201184935.GA12321@leaf>
	<CANeU7Qm1=8ks=Fu6LzjuAYxRqLPS3gssmD+uxNzDfN568Xxodw@mail.gmail.com>
	<20140202083838.GA20284@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:49775 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbaB0VAs (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 27 Feb 2014 16:00:48 -0500
Received: by mail-qa0-f43.google.com with SMTP id o15so4651140qap.16
        for <linux-sparse@vger.kernel.org>; Thu, 27 Feb 2014 13:00:47 -0800 (PST)
In-Reply-To: <20140202083838.GA20284@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Al Viro <viro@ftp.linux.org.uk>

On Sun, Feb 2, 2014 at 12:38 AM, Josh Triplett <josh@joshtriplett.org> wrote:
> I'd suggest that either it should have exactly the same behavior as it does
> when applied to the type of a function argument (suppressing
> Sparse-specific pointer qualifier mismatches on input), or it should be
> prohibited entirely on standalone variable declarations.  I'd be fine
> with the latter, if you prefer.

BTW, patch are welcome to make it consistent, hopefully in a not too
complicate way.

Chris
