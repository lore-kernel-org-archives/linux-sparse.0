From: Christopher Li <sparse@chrisli.org>
Subject: Re: Possible incorrect linearization of code (master branch)
Date: Tue, 7 Mar 2017 23:45:11 +0800
Message-ID: <CANeU7Qm4fYeTeiN61dCSgSGHTUNCjLGtjdJmBVbxXKu7cC_OPw@mail.gmail.com>
References: <CACXZuxeNopu3Syg+TCL3TLnhwmA84qkQ1NsN4hjL-VLPi6ASYA@mail.gmail.com>
 <20170306163638.huqjg6my2qhwyyzy@macpro.local> <CACXZuxd_6YS7cficTeuPayyYCT-0Q==i3hje_Xd-MtoAP6bLyQ@mail.gmail.com>
 <CAExDi1RSA0qgBEbH8DH9w573-g1DrH4DhOrUo_GDdnKVh--F-w@mail.gmail.com> <CACXZuxexwB_krnNULmiGMCySoaVqx1Q+KiuE_tPS7P59nT7giA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f44.google.com ([209.85.214.44]:38132 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753429AbdCGPqe (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Mar 2017 10:46:34 -0500
Received: by mail-it0-f44.google.com with SMTP id m27so6559132iti.1
        for <linux-sparse@vger.kernel.org>; Tue, 07 Mar 2017 07:45:12 -0800 (PST)
In-Reply-To: <CACXZuxexwB_krnNULmiGMCySoaVqx1Q+KiuE_tPS7P59nT7giA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Mar 7, 2017 at 6:39 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:

> As I mentioned before I am using Sparse to create a JIT compiler for
> C. So this needs to be callable as a library - and I need the ability
> to call it many times. Moreover it must be possible to call several
> instances of Sparse simultaneously without conflict. To achieve all
> this, all global state is held in a set of structures. The main change
> is that the most function calls have an additional argument. The other

Adding an additional argument is a very big change.


> changes are related to initialization of the various global structures
> used by Sparse.

In your usage case, is it possible to use some kind of lock to avoid
racing to initialize sparse?

> Generally I try to keep the code as far as possible
> identical to Sparse except for these changes. Even so merging is very
> painful.

May be need a script of some short to automate part of the change.

Do you have that big and painful change already?

Chris
