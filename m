From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: Re: [PATCH] arm64: sysreg: fix sparse warnings
Date: Thu, 15 Nov 2018 11:35:35 +0300
Message-ID: <20181115083535.usyjcdoz2f6zmssq@bars>
References: <20181109204747.10008-1-geomatsi@gmail.com>
 <20181110001615.GA5665@brain-police>
 <20181110111647.GA3511@speedy.hunter>
 <20181110170311.GA7700@brain-police>
 <20181110175404.gnks6sj3zzlz2it7@ltop.local>
 <2bb3e247-3b6f-adc6-6d6f-1e62f48a43e6@ramsayjones.plus.com>
 <20181114222540.fgddrx4xxsne5pdq@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181114222540.fgddrx4xxsne5pdq@ltop.local>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-sparse@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-sparse@vger.kernel.org

> > >>>>> the following sparse complaints:
> > >>>>>
> > >>>>> ./arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> > >>>>> ./arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> > >>>>>
> > >>>>> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> > >>>>> ---
> > >>>>>  arch/arm64/include/asm/sysreg.h | 4 ++--
> > >>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> > >>>>
> > >>>> I thought this was fixed in newer versions of sparse so that it treats
> > >>>> AArch64 as 64-bit? [see sparse commit 49d56b6969d2f]
> > >>>
> > >>> I am using up-to-date sparse. However this warning still appears,
> > >>> not sure why. Maybe sparse treats such constants as unsigned int ?
> > >>>
> > >>> Meanwhile it looks like I chose wrong type: it is enough to use UL
> > >>> instead of ULL to make sparse happy. In fact warning is clear
> > >>> about it.
> > >>
> > >> Ah yes, sorry. I misread the patch the first time around and thought you were
> > >> changing a UL suffix to a ULL suffix. So actually, I think this is just a
> > >> case of sparse getting confused about this constant because it's actually
> > >> going to get parsed by the pre-processor, which says:
> > >>
> > >>   | It [the preprocessor parsing #if] carries out all calculations in the
> > >>   | widest integer type known to the compiler; on most machines supported by
> > >>   | GCC this is 64 bits
> > >>
> > >> so I still think this is a false positive. Adding Luc in case he has any
> > >> ideas.
> > > 
> > > Well, I think the warning is 'correct' (and the message is quite
> > > clear about the 'possible' problem) but probably not useful enough.
> > 
> > yes, the warning is correct. I think the message is quite clear, so
> > would be happy to hear any possible improvements! ;-)
> 
> Oh, I was not talking about the message but, like Linus explained, that
> since no bits are lost here (and sparse has another warning in case some
> bits would be lost) and nothing is incorrect, the warning is not really
> interesting.
>  
> > (Also, correcting the source, in order to suppress these warnings,
> > should take mere seconds - for each such warning, of course).
> 
> Yes, sure, it was even the origin of the thread.
>  
> > > In fact, some months ago, it was agreed that sparse will only issue
> > > this warning when -Wpedantic is set but this flag is not yet handled.
> > 
> > I have patches, but I have been waiting for the 'official repo' issue
> > to get resolved. (If you remember, I was building on top of the current
> > official repo and continually merging to the master branch of your
> > github sparse.git - but I got bored of doing that!).
> 
> Yes, I understand. This should be solved now.
 
Hi,

Could you please clarify what is your resolution regarding that warning.
I pulled all the changes from sparse repository on kernel.org. However
the same warning is still here when building modules with C=2 option.

Regards,
Sergey
