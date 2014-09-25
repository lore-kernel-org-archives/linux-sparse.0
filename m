From: Pranith Kumar <bobby.prani@gmail.com>
Subject: Re: spurious warning for sizeof(bool)
Date: Wed, 24 Sep 2014 21:14:15 -0400
Message-ID: <CAJhHMCASJfwnmtju+npNCX=92_NFenv1B8N_pPOhpnUPxXTH+A@mail.gmail.com>
References: <CAJhHMCAee+Q=P3oRdGhMcA_x0cbWShd+SkPyqzpDaT2=DjC=EQ@mail.gmail.com>
 <CAJhHMCDhai4WxRg5_1PQXq=MpO4a6Eyv9+Ep7hu09irnqJVHDg@mail.gmail.com>
 <CANeU7Q=qmxN_mKmxQ1NKGdC9rQnDVYOFP9AkAx-X2Qq4sbnfcA@mail.gmail.com>
 <CAJhHMCALfvu9SgRoVBXXvyxtq2KQoymLSRnxvSP095tz6rO2Ng@mail.gmail.com> <CANeU7Q=Dvhvm-=6rPyr4fV+Sd8ajWnGH39msYqjua3G=pKqNOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vc0-f182.google.com ([209.85.220.182]:61636 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbaIYBOq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Sep 2014 21:14:46 -0400
Received: by mail-vc0-f182.google.com with SMTP id le20so7303336vcb.41
        for <linux-sparse@vger.kernel.org>; Wed, 24 Sep 2014 18:14:45 -0700 (PDT)
In-Reply-To: <CANeU7Q=Dvhvm-=6rPyr4fV+Sd8ajWnGH39msYqjua3G=pKqNOA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: "open list:SPARSE CHECKER" <linux-sparse@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>

On Wed, Sep 24, 2014 at 9:02 PM, Christopher Li <sparse@chrisli.org> wrote:
> On Thu, Sep 25, 2014 at 8:21 AM, Pranith Kumar <bobby.prani@gmail.com> wrote:
>> HI Chris,
>>
>> Could you please update the official sparse git repo?
>>
>> git://git.kernel.org/pub/scm/devel/sparse/sparse.git
>>
>
> Right now it is at a relative clean stage since the anonymous union
> warning is fixed.
>
> I just pushed it to official repository.
>
> Chris

Verified that it works. Thank you.

-- 
Pranith
