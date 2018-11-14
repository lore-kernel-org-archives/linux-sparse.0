From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] arm64: sysreg: fix sparse warnings
Date: Wed, 14 Nov 2018 23:25:41 +0100
Message-ID: <20181114222540.fgddrx4xxsne5pdq@ltop.local>
References: <20181109204747.10008-1-geomatsi@gmail.com>
 <20181110001615.GA5665@brain-police>
 <20181110111647.GA3511@speedy.hunter>
 <20181110170311.GA7700@brain-police>
 <20181110175404.gnks6sj3zzlz2it7@ltop.local>
 <2bb3e247-3b6f-adc6-6d6f-1e62f48a43e6@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <2bb3e247-3b6f-adc6-6d6f-1e62f48a43e6@ramsayjones.plus.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Sergey Matyukevich <geomatsi@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-sparse@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-sparse@vger.kernel.org

On Mon, Nov 12, 2018 at 04:32:31PM +0000, Ramsay Jones wrote:
> 
> 
> On 10/11/2018 17:54, Luc Van Oostenryck wrote:
> > On Sat, Nov 10, 2018 at 05:03:21PM +0000, Will Deacon wrote:
> >> On Sat, Nov 10, 2018 at 02:16:47PM +0300, Sergey Matyukevich wrote:
> >>> On Sat, Nov 10, 2018 at 12:16:16AM +0000, Will Deacon wrote:
> >>>> On Fri, Nov 09, 2018 at 11:47:47PM +0300, Sergey Matyukevich wrote:
> >>>>> Specify correct type for the constants to avoid
> >>>>> the following sparse complaints:
> >>>>>
> >>>>> ./arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> >>>>> ./arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> >>>>>
> >>>>> Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> >>>>> ---
> >>>>>  arch/arm64/include/asm/sysreg.h | 4 ++--
> >>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> I thought this was fixed in newer versions of sparse so that it treats
> >>>> AArch64 as 64-bit? [see sparse commit 49d56b6969d2f]
> >>>
> >>> I am using up-to-date sparse. However this warning still appears,
> >>> not sure why. Maybe sparse treats such constants as unsigned int ?
> >>>
> >>> Meanwhile it looks like I chose wrong type: it is enough to use UL
> >>> instead of ULL to make sparse happy. In fact warning is clear
> >>> about it.
> >>
> >> Ah yes, sorry. I misread the patch the first time around and thought you were
> >> changing a UL suffix to a ULL suffix. So actually, I think this is just a
> >> case of sparse getting confused about this constant because it's actually
> >> going to get parsed by the pre-processor, which says:
> >>
> >>   | It [the preprocessor parsing #if] carries out all calculations in the
> >>   | widest integer type known to the compiler; on most machines supported by
> >>   | GCC this is 64 bits
> >>
> >> so I still think this is a false positive. Adding Luc in case he has any
> >> ideas.
> > 
> > Well, I think the warning is 'correct' (and the message is quite
> > clear about the 'possible' problem) but probably not useful enough.
> 
> yes, the warning is correct. I think the message is quite clear, so
> would be happy to hear any possible improvements! ;-)

Oh, I was not talking about the message but, like Linus explained, that
since no bits are lost here (and sparse has another warning in case some
bits would be lost) and nothing is incorrect, the warning is not really
interesting.
 
> (Also, correcting the source, in order to suppress these warnings,
> should take mere seconds - for each such warning, of course).

Yes, sure, it was even the origin of the thread.
 
> > In fact, some months ago, it was agreed that sparse will only issue
> > this warning when -Wpedantic is set but this flag is not yet handled.
> 
> I have patches, but I have been waiting for the 'official repo' issue
> to get resolved. (If you remember, I was building on top of the current
> official repo and continually merging to the master branch of your
> github sparse.git - but I got bored of doing that!).

Yes, I understand. This should be solved now.

> > I'll look at this next week.
> 
> I stopped work on my patches months ago, after doing just enough to
> enable me to work on git without tearing my hair out on Linux Mint 19
> (or Ubuntu 18.04, Fedora 27+ etc.). ;-)
> 
> I was working on -Wsystem-headers, so this warning (along with some
> other __extension__ warnings in the system headers) do not cause me

Interesting. I'll be glad to review them.

> any further issues on git. (that would not help on the kernel, of course).
> 
> [BTW, I have been building/testing/running the master branch of
> git://github.com/lucvoo/sparse.git for months now, without seeing
> any regressions.]

That's always good to know. Thank you.

-- Luc 
