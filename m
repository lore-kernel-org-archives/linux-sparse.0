From: Christopher Li <sparse@chrisli.org>
Subject: Re: fun with declarations and definitions
Date: Mon, 2 Feb 2009 12:17:06 -0800
Message-ID: <70318cbf0902021217r634f94a0y46fe572091a78634@mail.gmail.com>
References: <20090202073018.GB28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:4023 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753758AbZBBURG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 2 Feb 2009 15:17:06 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1637605rvb.1
        for <linux-sparse@vger.kernel.org>; Mon, 02 Feb 2009 12:17:06 -0800 (PST)
In-Reply-To: <20090202073018.GB28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

On Sun, Feb 1, 2009 at 11:30 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>        There are several interesting problems caused by the fact that
> we create a separate symbol for each declaration of given function.

Thanks for the patch. That is great. This is actually one of the two
hard problem in
sparse. I haven't able to solved them. (BTW, the other one was running
out of modifier bits.)

You patch seems base on Josh's tree. In my tree the context change has been
back out, so the  validation/context-named.c is gone. Other than that, the patch
seems apply fine. I will take a closer look at it and get back to you.

Chris
