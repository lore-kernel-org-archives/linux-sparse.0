From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: Possible incorrect linearization of code (master branch)
Date: Mon, 6 Mar 2017 17:36:40 +0100
Message-ID: <20170306163638.huqjg6my2qhwyyzy@macpro.local>
References: <CACXZuxeNopu3Syg+TCL3TLnhwmA84qkQ1NsN4hjL-VLPi6ASYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36892 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754434AbdCFQp5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2017 11:45:57 -0500
Received: by mail-wm0-f43.google.com with SMTP id n11so69665669wma.0
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 08:45:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACXZuxeNopu3Syg+TCL3TLnhwmA84qkQ1NsN4hjL-VLPi6ASYA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Mon, Mar 06, 2017 at 03:22:19PM +0000, Dibyendu Majumdar wrote:
> main:
> .L2:
>         <entry-point>
>         call.64     %r10 <- incr, "abcde"
>         setne.32    %r15 <- %r13, $101
>         ret.32      %r15


Hi,
This is already fixed in commit
	 https://git.kernel.org/cgit/devel/sparse/sparse.git/commit/?h=sparse-next-20170306&id=b8c268640114d614178d4875fbe0f5e6b53b036b 

Luc
