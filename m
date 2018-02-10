From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 3/8] early return if null ctype in evaluate_conditional()
Date: Sat, 10 Feb 2018 20:43:50 +0100
Message-ID: <20180210194350.76pdd5sukyfvqqae@ltop.local>
References: <20180202121735.39621-1-luc.vanoostenryck@gmail.com>
 <20180202121735.39621-4-luc.vanoostenryck@gmail.com>
 <CANeU7QmA+2WQcZRbgG9bb_N8su1SH90U3JFyyntiyijAXJbCxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f180.google.com ([209.85.128.180]:42031 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751371AbeBJTnz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Feb 2018 14:43:55 -0500
Received: by mail-wr0-f180.google.com with SMTP id 41so11416879wrc.9
        for <linux-sparse@vger.kernel.org>; Sat, 10 Feb 2018 11:43:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QmA+2WQcZRbgG9bb_N8su1SH90U3JFyyntiyijAXJbCxQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Feb 10, 2018 at 11:28:44AM -0800, Christopher Li wrote:
> On Fri, Feb 2, 2018 at 4:17 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > NB: no functional changes here.
> >
> This is not straightly necessary to re-indent a section of the code.

Not needed but it was the prupose of the patch so that one of the following
patches become very clear about the functional change it made.
It's a very good things to separate functional from non-functional changes.

-- Luc
