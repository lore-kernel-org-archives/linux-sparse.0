From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] arm64: sysreg: fix sparse warnings
Date: Sat, 10 Nov 2018 18:54:05 +0100
Message-ID: <20181110175404.gnks6sj3zzlz2it7@ltop.local>
References: <20181109204747.10008-1-geomatsi@gmail.com>
 <20181110001615.GA5665@brain-police>
 <20181110111647.GA3511@speedy.hunter>
 <20181110170311.GA7700@brain-police>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181110170311.GA7700@brain-police>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: Sergey Matyukevich <geomatsi@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-sparse@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-sparse@vger.kernel.org

On Sat, Nov 10, 2018 at 05:03:21PM +0000, Will Deacon wrote:
> On Sat, Nov 10, 2018 at 02:16:47PM +0300, Sergey Matyukevich wrote:
> > On Sat, Nov 10, 2018 at 12:16:16AM +0000, Will Deacon wrote:
> > > On Fri, Nov 09, 2018 at 11:47:47PM +0300, Sergey Matyukevich wrote:
> > > > Specify correct type for the constants to avoid
> > > > the following sparse complaints:
> > > > 
> > > > ./arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> > > > ./arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> > > > 
> > > > Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> > > > ---
> > > >  arch/arm64/include/asm/sysreg.h | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > I thought this was fixed in newer versions of sparse so that it treats
> > > AArch64 as 64-bit? [see sparse commit 49d56b6969d2f]
> > 
> > I am using up-to-date sparse. However this warning still appears,
> > not sure why. Maybe sparse treats such constants as unsigned int ?
> > 
> > Meanwhile it looks like I chose wrong type: it is enough to use UL
> > instead of ULL to make sparse happy. In fact warning is clear
> > about it.
> 
> Ah yes, sorry. I misread the patch the first time around and thought you were
> changing a UL suffix to a ULL suffix. So actually, I think this is just a
> case of sparse getting confused about this constant because it's actually
> going to get parsed by the pre-processor, which says:
> 
>   | It [the preprocessor parsing #if] carries out all calculations in the
>   | widest integer type known to the compiler; on most machines supported by
>   | GCC this is 64 bits
> 
> so I still think this is a false positive. Adding Luc in case he has any
> ideas.

Well, I think the warning is 'correct' (and the message is quite
clear about the 'possible' problem) but probably not useful enough.
In fact, some months ago, it was agreed that sparse will only issue
this warning when -Wpedantic is set but this flag is not yet handled.

I'll look at this next week.

-- Luc
