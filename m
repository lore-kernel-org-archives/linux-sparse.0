From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 2/2] mmc: fix integer assignments to pointer
Date: Thu, 25 Aug 2011 00:03:45 +0530
Message-ID: <CANfBPZ_ZJB-0zZYJpeSqzo7U18s71nOd8=5ZyKQ8=A6dzg+6-A@mail.gmail.com>
References: <1314114363-6767-1-git-send-email-svenkatr@ti.com>
 <1314114363-6767-3-git-send-email-svenkatr@ti.com> <m27h643x8k.fsf@bob.laptop.org>
 <20110823172851.GB1784@leaf> <874o18m2cn.fsf@blp.benpfaff.org>
 <20110823181359.GB3418@leaf> <m2mxf02d9h.fsf@bob.laptop.org> <20110823203803.GA17148@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <20110823203803.GA17148@merkur.ravnborg.org>
Sender: linux-mmc-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Chris Ball <cjb@laptop.org>, Josh Triplett <josh@joshtriplett.org>, blp@cs.stanford.edu, linux-mmc@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Wed, Aug 24, 2011 at 2:08 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
>>
>> I'm still a little confused -- the {0} or memset(0, struct ..);
>> formations are used often in the kernel, even with pointers involved=
=2E
>> Is the warning (Wnon_pointer_null) run against the kernel by default=
,
>> or did Venkatraman add it manually? =A0If default, is it catching bu=
gs?
>
> Did a quick "allnoconfig" build. With this minimal build the warning =
only triggered three times.
> So a lot of these has been fixed already.
>
> =A0 =A0 =A0 =A0Sam
>
I did my typical omap build on mainline and mmc-next and see that the w=
arnings
have increased, and not fixed.
I will post upated patch series.
