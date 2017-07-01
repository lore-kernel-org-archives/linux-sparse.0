From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 0/7] put struct symbol & friends on diet
Date: Sat, 1 Jul 2017 10:45:22 +0200
Message-ID: <20170701084521.4vfwmoc5c3zm4u56@ltop.local>
References: <20170629051646.35988-1-luc.vanoostenryck@gmail.com>
 <CANeU7QkPYJJ4HdNceB2XvHGVoHH2RUcZr4Hr1wEF_AX51cQMqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37828 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbdGAIpa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 1 Jul 2017 04:45:30 -0400
Received: by mail-wm0-f41.google.com with SMTP id i127so65595796wma.0
        for <linux-sparse@vger.kernel.org>; Sat, 01 Jul 2017 01:45:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QkPYJJ4HdNceB2XvHGVoHH2RUcZr4Hr1wEF_AX51cQMqQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Thu, Jun 29, 2017 at 03:04:16PM -0700, Christopher Li wrote:
> On Wed, Jun 28, 2017 at 10:16 PM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > The goal of this series is to decrease sparse's memory consumption
> > by decreasing the size of some of the structure.
> 
> Do you have that in git repository some where?
> 
> Right now I have different review work flow for patches vs git.
> Patches will be fetch from patchworks and git from git fetch.
> If you are going to do a git pull later on, It would be nice to
> provide a git url for the series as well.

Yes, I have.
But for the moment, I was more interested in feedback on conceptual
level. I'll need to consolidate things and then I'll resend things.

-- Luc
