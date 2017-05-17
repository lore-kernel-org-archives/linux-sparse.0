From: Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH] Makefile: remove SMATCH_DATA smatch_data/kernel.balanced_funcs
 item
Date: Wed, 17 May 2017 12:39:20 +0100
Message-ID: <CAG27Bk0t_dJbneNZD5_3x52hRc76m_vGJNt0hnpqGc-NBULHGQ@mail.gmail.com>
References: <20170516174308.27102-1-kerolasa@iki.fi> <20170517092808.xwxofmiywj46un2q@mwanda>
Reply-To: kerolasa@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34186 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbdEQLjV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 17 May 2017 07:39:21 -0400
Received: by mail-qk0-f195.google.com with SMTP id u75so1186701qka.1
        for <linux-sparse@vger.kernel.org>; Wed, 17 May 2017 04:39:21 -0700 (PDT)
In-Reply-To: <20170517092808.xwxofmiywj46un2q@mwanda>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-sparse@vger.kernel.org

On 17 May 2017 at 10:28, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Tue, May 16, 2017 at 06:43:08PM +0100, Sami Kerola wrote:
>> File was removed recently.  Removal commit missed Makefile clean up.
>
> EEep...  Thanks.  I'll push this in a few hours.
>
> I need to update my build scripts to do a install.  There isn't a
> `make uninstall` target.  How are you cleaning up?

I never do, overwriting seems to work fine. Maybe I should try to
uninstall one day
to see how things work.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
