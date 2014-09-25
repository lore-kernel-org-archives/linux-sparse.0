From: Pranith Kumar <bobby.prani@gmail.com>
Subject: Re: spurious warning for sizeof(bool)
Date: Wed, 24 Sep 2014 20:21:30 -0400
Message-ID: <CAJhHMCALfvu9SgRoVBXXvyxtq2KQoymLSRnxvSP095tz6rO2Ng@mail.gmail.com>
References: <CAJhHMCAee+Q=P3oRdGhMcA_x0cbWShd+SkPyqzpDaT2=DjC=EQ@mail.gmail.com>
 <CAJhHMCDhai4WxRg5_1PQXq=MpO4a6Eyv9+Ep7hu09irnqJVHDg@mail.gmail.com> <CANeU7Q=qmxN_mKmxQ1NKGdC9rQnDVYOFP9AkAx-X2Qq4sbnfcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:56103 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbaIYAWB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Sep 2014 20:22:01 -0400
Received: by mail-vc0-f176.google.com with SMTP id la4so5645217vcb.21
        for <linux-sparse@vger.kernel.org>; Wed, 24 Sep 2014 17:22:00 -0700 (PDT)
In-Reply-To: <CANeU7Q=qmxN_mKmxQ1NKGdC9rQnDVYOFP9AkAx-X2Qq4sbnfcA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: "open list:SPARSE CHECKER" <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

On Wed, Sep 24, 2014 at 8:02 PM, Christopher Li <sparse@chrisli.org> wrote:
>>>
>>> I am getting these spurious warnings for a sizeof(bool) expression
>>>
>>> kernel/rcu/tree.c:202:14: warning: expression using sizeof bool
>>>
>>> Is this going to be fixed anytime soon?
>>>
>
> Which sparse version are you using? In the git chrisl repository,
> sparse does not give that warning by default any more.
>
> Chris

HI Chris,

Could you please update the official sparse git repo?

git://git.kernel.org/pub/scm/devel/sparse/sparse.git

-- 
Pranith
