From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/2] warn on implicit type
Date: Thu, 8 Jun 2017 09:25:17 +0200
Message-ID: <20170608072514.vicslfcnvqalauaq@ltop.local>
References: <20170608024736.49780-1-luc.vanoostenryck@gmail.com>
 <CANeU7Qny5i4TDMWihLv9CnPXWTpVsZfZXG8dqUR3USYTsJZpNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34101 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbdFHHZV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 8 Jun 2017 03:25:21 -0400
Received: by mail-wm0-f66.google.com with SMTP id 70so5818292wme.1
        for <linux-sparse@vger.kernel.org>; Thu, 08 Jun 2017 00:25:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7Qny5i4TDMWihLv9CnPXWTpVsZfZXG8dqUR3USYTsJZpNA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Jun 07, 2017 at 11:16:27PM -0700, Christopher Li wrote:
> On Wed, Jun 7, 2017 at 7:47 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > The goal of this mini-series is to warn about implicit.
> > It's part of a larger series whose goal is to straighten
> > situations where the return type of a function doesn't
> > match the type of what is returned, often silently and
> > with incoherence in the code generated.
> 
> Looks good to me.
> 
> BTW, are those intend to merge into sparse-next or for
> review only?

It's not something for the release, so for review only.
 
> If it is for sparse-next. I kind of wish to have one dedicate
> branch to pull from you. You can still have different branch
> for review. It is just went I pull, I don't have to merge between
> your branches.

Yes, understood.
Like for the previous ones, when it will be a pull request
it will be clearly so (with 'PULL' in the title and the output
of 'git request-pull' in the body).

-- Luc
