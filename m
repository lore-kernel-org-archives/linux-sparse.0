From: Christopher Li <sparse@chrisli.org>
Subject: Re: spurious warning for sizeof(bool)
Date: Thu, 25 Sep 2014 09:02:43 +0800
Message-ID: <CANeU7Q=Dvhvm-=6rPyr4fV+Sd8ajWnGH39msYqjua3G=pKqNOA@mail.gmail.com>
References: <CAJhHMCAee+Q=P3oRdGhMcA_x0cbWShd+SkPyqzpDaT2=DjC=EQ@mail.gmail.com>
	<CAJhHMCDhai4WxRg5_1PQXq=MpO4a6Eyv9+Ep7hu09irnqJVHDg@mail.gmail.com>
	<CANeU7Q=qmxN_mKmxQ1NKGdC9rQnDVYOFP9AkAx-X2Qq4sbnfcA@mail.gmail.com>
	<CAJhHMCALfvu9SgRoVBXXvyxtq2KQoymLSRnxvSP095tz6rO2Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:64602 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbaIYBCp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Sep 2014 21:02:45 -0400
Received: by mail-wi0-f176.google.com with SMTP id fb4so7952839wid.9
        for <linux-sparse@vger.kernel.org>; Wed, 24 Sep 2014 18:02:43 -0700 (PDT)
In-Reply-To: <CAJhHMCALfvu9SgRoVBXXvyxtq2KQoymLSRnxvSP095tz6rO2Ng@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: "open list:SPARSE CHECKER" <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

On Thu, Sep 25, 2014 at 8:21 AM, Pranith Kumar <bobby.prani@gmail.com> wrote:
> HI Chris,
>
> Could you please update the official sparse git repo?
>
> git://git.kernel.org/pub/scm/devel/sparse/sparse.git
>

Right now it is at a relative clean stage since the anonymous union
warning is fixed.

I just pushed it to official repository.

Chris
