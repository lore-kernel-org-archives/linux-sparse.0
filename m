From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v4 2/9] Remove single-store shortcut
Date: Wed, 9 Aug 2017 22:02:03 +0200
Message-ID: <CAMHZB6FFs-SMSLr3awsHB+k1CTwwezrtbidS2bOMKJ1F2j_jng@mail.gmail.com>
References: <CANeU7Qk99kn3etn8yoEKKFzcW15wHjt7OYPSpZhqCDc4DE3EDQ@mail.gmail.com>
 <20170809193806.30975-1-luc.vanoostenryck@gmail.com> <20170809193806.30975-3-luc.vanoostenryck@gmail.com>
 <CACXZuxejN5zBn4NN7XXmGhM26NJMiGAutW7+csb7kVPjWZRVLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36168 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751890AbdHIUCE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 9 Aug 2017 16:02:04 -0400
Received: by mail-qk0-f169.google.com with SMTP id d136so42399824qkg.3
        for <linux-sparse@vger.kernel.org>; Wed, 09 Aug 2017 13:02:04 -0700 (PDT)
In-Reply-To: <CACXZuxejN5zBn4NN7XXmGhM26NJMiGAutW7+csb7kVPjWZRVLg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Christopher Li <sparse@chrisli.org>

On Wed, Aug 9, 2017 at 9:47 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi Luc,
>
> This this change independent of the rest of changes in the series -
> i.e. can I just apply this change?

Absolutely.

-- Luc
