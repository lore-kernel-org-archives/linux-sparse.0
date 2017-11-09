From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 9/9] option: handle switches by table
Date: Thu, 9 Nov 2017 22:02:53 +0100
Message-ID: <20171109210252.52kdtpgsbjvmki3j@ltop.local>
References: <20171108101008.43804-1-luc.vanoostenryck@gmail.com>
 <20171108101008.43804-10-luc.vanoostenryck@gmail.com>
 <CANeU7Qm+S3T0sKPBZCVCD=nePQGWdGAzzShR=UQnKx+mQf-LoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:57316 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753851AbdKIVC5 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 9 Nov 2017 16:02:57 -0500
Received: by mail-wm0-f65.google.com with SMTP id z3so20395684wme.5
        for <linux-sparse@vger.kernel.org>; Thu, 09 Nov 2017 13:02:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Qm+S3T0sKPBZCVCD=nePQGWdGAzzShR=UQnKx+mQf-LoA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Nov 10, 2017 at 02:42:48AM +0800, Christopher Li wrote:
> On Wed, Nov 8, 2017 at 6:10 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Currently, the parsing of options is often quite ad-hoc and thus:
> > - need a lot of code
> > - is not clear at all
> >
> > Improve this by making this table driven.
> 
> Please start the patch with the greatest idea table driven option parsing.

You don't seems to see that (most of) these patches are preparatory
steps to reach this goal.
 
If you think that it's simpler to review, test & debug once they are
all squashed in a single patch, fine, it's your opinion, not mine.

-- Luc
