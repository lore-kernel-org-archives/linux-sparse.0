From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: pass machine size to sparse
Date: Wed, 21 Jun 2017 17:12:54 +0100
Message-ID: <20170621161254.GF6041@arm.com>
References: <20170620122443.35880-1-luc.vanoostenryck@gmail.com>
 <20170620154938.GH21131@arm.com>
 <20170620162431.zi6qd3jby7shyu46@ltop.local>
 <20170620170401.GA28035@arm.com>
 <20170620190739.ijtpo3ekibxi47qj@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170620190739.ijtpo3ekibxi47qj@ltop.local>
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-sparse@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-sparse@vger.kernel.org

On Tue, Jun 20, 2017 at 09:07:40PM +0200, Luc Van Oostenryck wrote:
> On Tue, Jun 20, 2017 at 06:04:01PM +0100, Will Deacon wrote:
> > On Tue, Jun 20, 2017 at 06:24:32PM +0200, Luc Van Oostenryck wrote:
> > > On Tue, Jun 20, 2017 at 04:49:39PM +0100, Will Deacon wrote:
> > > > Looks fine to me, but just wondering whether or not we should also be
> > > > passing something to indicate the endianness of the target. Does sparse care
> > > > about that?
> > > 
> > > Yes, we should. sparse doesn't care per-se but some macros, structures
> > > or whole portion of code may depends on '__{LITTLE,BIG}_ENDIAN__'
> > > being defined or not, for example (but I don't think it will make
> > > a big difference, at least nothing like the 629904 'constant is so big'
> > > warnings we have now due to the missing -m64).
> > > 
> > > For this, you have two possibilities:
> > > 1) just doing something like PPC:
> > > 	+ifdef CONFIG_CPU_BIG_ENDIAN
> > > 	+CHECKFLAGS     += -D__BIG_ENDIAN__
> > > 	+else
> > > 	+CHECKFLAGS     += -D__LITTLE_ENDIAN__
> > > 	+endif
> > >    This will work now. I can't send you a proper patch if you wish.
> > > 
> > > 2) a cleaner solution, IMO, would be to teach sparse about
> > >    -mlittle-endian/-mbig-endian. In fact I already wrote the patch
> > >    earlier today. But of course, you will need to wait for the patch
> > >    to reach sparse's master and then compile sparse yourself or wait
> > >    for a new release (which shouldn't take much long, though).
> > 
> > If you do that, you could also teach it that AArch64 is 64-bit ;)
> 
> Well, currently sparse is arch agnostic and I think it's a good thing.
> For the few arch specifities you have to use some of the '-m' flags
> (like -m32/-m64, -msize-long). So, for the moment the '-m64' flag
> is needed, thus the patch.

Ok, I'll pick your patch up then. The endianness case is more interesting,
because I don't think __BIG_ENDIAN__ and __LITTLE_ENDIAN__ are the defines
to use; the kernel seems to omit the trailing underscores afaict.

Will
