From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Possible incorrect linearization of code (master branch)
Date: Mon, 6 Mar 2017 22:39:42 +0000
Message-ID: <CACXZuxexwB_krnNULmiGMCySoaVqx1Q+KiuE_tPS7P59nT7giA@mail.gmail.com>
References: <CACXZuxeNopu3Syg+TCL3TLnhwmA84qkQ1NsN4hjL-VLPi6ASYA@mail.gmail.com>
 <20170306163638.huqjg6my2qhwyyzy@macpro.local> <CACXZuxd_6YS7cficTeuPayyYCT-0Q==i3hje_Xd-MtoAP6bLyQ@mail.gmail.com>
 <CAExDi1RSA0qgBEbH8DH9w573-g1DrH4DhOrUo_GDdnKVh--F-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f48.google.com ([209.85.214.48]:32860 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753129AbdCGAjr (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2017 19:39:47 -0500
Received: by mail-it0-f48.google.com with SMTP id w124so4792678itb.0
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 16:37:55 -0800 (PST)
In-Reply-To: <CAExDi1RSA0qgBEbH8DH9w573-g1DrH4DhOrUo_GDdnKVh--F-w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On 6 March 2017 at 19:26, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Mon, Mar 6, 2017 at 7:47 PM, Dibyendu Majumdar
>> Because I have a modified
>> version of Sparse with all global state removed, merging changes is a
>> bit painful as it has be done manually.
>
> I can imagine this.
> I, of course, hve no idea why you (have to) do this but I can only very strongly
> advice you to try to avoid this as much as possible.
>

As I mentioned before I am using Sparse to create a JIT compiler for
C. So this needs to be callable as a library - and I need the ability
to call it many times. Moreover it must be possible to call several
instances of Sparse simultaneously without conflict. To achieve all
this, all global state is held in a set of structures. The main change
is that the most function calls have an additional argument. The other
changes are related to initialization of the various global structures
used by Sparse. Generally I try to keep the code as far as possible
identical to Sparse except for these changes. Even so merging is very
painful.

Regards
Dibyendu
