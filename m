From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] avoid crash with test-linearize -vv
Date: Fri, 24 Mar 2017 08:49:52 +0100
Message-ID: <20170324074951.vbbtsqvsqcc7f2j3@macbook.local>
References: <20170319180118.83953-1-luc.vanoostenryck@gmail.com>
 <CANeU7QnSaE6TsnRLXAufpcczd4ouaRKK+vSQm_r8YC9A0Rv-sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35382 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbdCXHtz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 24 Mar 2017 03:49:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id z133so1571300wmb.2
        for <linux-sparse@vger.kernel.org>; Fri, 24 Mar 2017 00:49:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QnSaE6TsnRLXAufpcczd4ouaRKK+vSQm_r8YC9A0Rv-sw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

On Thu, Mar 23, 2017 at 08:03:36PM -0700, Christopher Li wrote:
> On Sun, Mar 19, 2017 at 11:01 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > When verbose is set to 2 or higher, show_instruction()
> > also display removed instructions. Some of these instructions
> > can have their associated symbol removed and set to NULL
> > which will cause a crash with 'test-linearize -vv'.
> >
> > Fix this by avoiding to dereference symbol's details of
> > removed instructions.
> 
> I like to apply it. Can you add SOB?

Sure.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
