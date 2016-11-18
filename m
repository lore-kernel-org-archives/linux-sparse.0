From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] Fix type checking of variadic functions
Date: Fri, 18 Nov 2016 13:30:06 +0100
Message-ID: <20161118123005.GB476@macbook.local>
References: <20161102171349.17666-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qm0WbqFA1H6w7U=KmeLc90tyJdfsfQFqC4H_-c4mMQ1Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35332 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbcKRMaJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Nov 2016 07:30:09 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so5716874wme.2
        for <linux-sparse@vger.kernel.org>; Fri, 18 Nov 2016 04:30:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qm0WbqFA1H6w7U=KmeLc90tyJdfsfQFqC4H_-c4mMQ1Hw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>

On Thu, Nov 17, 2016 at 08:06:41AM +0800, Christopher Li wrote:
> Speaking of the test case, there are two case can be added:
> 
> void arg_incomplete();
> void arg_incomplete(int a) {} /* check-should-pass */
> 
> void arg_incomplete_vararg();
> void arg_incomplete_vararg(int a, ...) {} /* check-should-fail */
> 
> Sparse handle the first one incorrectly. But that is a separate issue,
> we can address it in a different patch.
> 
> Will apply.
> 
> Chris
> --

Yes. I'll look at this later.

Luc
