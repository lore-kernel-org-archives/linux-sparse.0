From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 4/8] add helper: valid_type()
Date: Sat, 10 Feb 2018 11:38:11 -0800
Message-ID: <CANeU7Q=BT0Mk30HRF-jaOHwqB6qckrC+muXwb7+D0pRDmDMdTw@mail.gmail.com>
References: <20180202121735.39621-1-luc.vanoostenryck@gmail.com> <20180202121735.39621-5-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36919 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbeBJTiM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 10 Feb 2018 14:38:12 -0500
Received: by mail-qk0-f171.google.com with SMTP id c128so14095331qkb.4
        for <linux-sparse@vger.kernel.org>; Sat, 10 Feb 2018 11:38:12 -0800 (PST)
In-Reply-To: <20180202121735.39621-5-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Feb 2, 2018 at 4:17 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> 'bad_type' is used for ... bad types instead of NULL
> in order to avoid later lots of null-checking.

Is there a good reason to keep both NULL and "bad_type"
to represent bad types?

May be we should keep it simple, make NULL as the
haven't been evaluated. After evaluate if there is type
error, replace the NULL as bad type. So that we can tell
this expression is evaluated or not.

In other word, replace all usage of NULL as bad type into
"bad_type". That would be more consistent.

Chris
