From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 4/8] add helper: valid_type()
Date: Sat, 10 Feb 2018 20:51:11 +0100
Message-ID: <20180210195109.zqfiihvn7wqkjzc5@ltop.local>
References: <20180202121735.39621-1-luc.vanoostenryck@gmail.com>
 <20180202121735.39621-5-luc.vanoostenryck@gmail.com>
 <CANeU7Q=BT0Mk30HRF-jaOHwqB6qckrC+muXwb7+D0pRDmDMdTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f172.google.com ([209.85.128.172]:38651 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbeBJTvO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Feb 2018 14:51:14 -0500
Received: by mail-wr0-f172.google.com with SMTP id t94so11424590wrc.5
        for <linux-sparse@vger.kernel.org>; Sat, 10 Feb 2018 11:51:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7Q=BT0Mk30HRF-jaOHwqB6qckrC+muXwb7+D0pRDmDMdTw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sat, Feb 10, 2018 at 11:38:11AM -0800, Christopher Li wrote:
> On Fri, Feb 2, 2018 at 4:17 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > 'bad_type' is used for ... bad types instead of NULL
> > in order to avoid later lots of null-checking.
> 
> Is there a good reason to keep both NULL and "bad_type"
> to represent bad types?
> 
> May be we should keep it simple, make NULL as the
> haven't been evaluated. After evaluate if there is type
> error, replace the NULL as bad type. So that we can tell
> this expression is evaluated or not.
> 
> In other word, replace all usage of NULL as bad type into
> "bad_type". That would be more consistent.

This is indded one of the longer term goal (or at least to
make things much cleaner).
For the moment, it's far from being the case though, because
some of the functions return NULL to indicate that they
failed and then this return value is used and assigned.
It's quite a bit messy.

-- Luc
