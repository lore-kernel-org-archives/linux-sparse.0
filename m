From: Christopher Li <sparse@chrisli.org>
Subject: Re: RFC: Move sparse.git inside linux-kernel-2.6.git?
Date: Thu, 18 Jun 2009 13:40:15 -0700
Message-ID: <70318cbf0906181340j3b04b2b4hb95f6c8648dea70b@mail.gmail.com>
References: <20090618192058.GB14086@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f195.google.com ([209.85.221.195]:44531 "EHLO
	mail-qy0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbZFRUkN (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 18 Jun 2009 16:40:13 -0400
Received: by qyk33 with SMTP id 33so504408qyk.33
        for <linux-sparse@vger.kernel.org>; Thu, 18 Jun 2009 13:40:15 -0700 (PDT)
In-Reply-To: <20090618192058.GB14086@uranus.ravnborg.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Jun 18, 2009 at 12:20 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
>
> The linux kernel is one of the major customers of
> sparse and several sparse hackers are very
> active on the kernel front too.
>
> How about combining forces and move sparse.git inside
> the kernel.

I think it is better keep it separate. The main reason is to have
a clean history.  Sparse has much lighter activity than kernel.
The sparse history will become noise compare to the kernel
one. So it is not easy to bisect sparse bugs. It will sync tons of kernel
source with it.


That being said, I think we still can make sparse friendly to kernel.
For example, we can make a sparse tree sym link under tools of the kernel
tree. The kernel makefile will use that tree if it is there, as if it is part
of the kernel. So we can have the benefit you mention without mess up
the sparse history.

We can even make some build target in the kernel to check out a copy
of the sparse tree in the tools/sparse directory. That should solve the
problem that people need to know where to check out.

Chris
