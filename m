From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] arm64: sysreg: fix sparse warnings
Date: Fri, 16 Nov 2018 11:34:00 +0100
Message-ID: <20181116103359.wywpaeanhoceqhgb@ltop.local>
References: <20181109204747.10008-1-geomatsi@gmail.com>
 <20181110001615.GA5665@brain-police>
 <20181110111647.GA3511@speedy.hunter>
 <20181110170311.GA7700@brain-police>
 <20181110175404.gnks6sj3zzlz2it7@ltop.local>
 <2bb3e247-3b6f-adc6-6d6f-1e62f48a43e6@ramsayjones.plus.com>
 <20181114222540.fgddrx4xxsne5pdq@ltop.local>
 <20181115083535.usyjcdoz2f6zmssq@bars>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181115083535.usyjcdoz2f6zmssq@bars>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sergey Matyukevich <geomatsi@gmail.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-sparse@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-sparse@vger.kernel.org

> Hi,
> 
> Could you please clarify what is your resolution regarding that warning.
> I pulled all the changes from sparse repository on kernel.org. However
> the same warning is still here when building modules with C=2 option.

Hi,

Yes, the warning is still there since it's maybe not desired but
is at least legit. For the short term, I think the best is your
original patch (but using UL as the prefix). I would be glad to
ack such a patch (I tried to answer in the original thread but
I never found it although I should be subscribed to the
linux-arm-kernel mailing list).

For the slightly longer term, I'll need to see how Ramsay's
patches can also be used for kernel code.

Best regards,
-- Luc
