From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC 2/4] include/linux/compiler.h: allow memory operands
Date: Mon, 7 Jan 2019 13:16:50 -0500
Message-ID: <20190107131350-mutt-send-email-mst@kernel.org>
References: <20190102205715.14054-1-mst@redhat.com>
	<20190102205715.14054-3-mst@redhat.com>
	<20190107175427.GB22911@fuggles.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190107175427.GB22911@fuggles.cambridge.arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Will Deacon <will.deacon@arm.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, linux-arch@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Daniel Lustig <dlustig@nvidia.com>, Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, virtualization@lists.linux-foundation.org, David Howells <dhowells@redhat.com>, linux-sparse@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, netdev@vger.kernel.org, Luc Maranget <luc.maranget@inria.fr>, Jade Alglave <j.alglave@ucl.ac.uk>, Boqun Feng <boqun.feng@gmail.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
List-Id: linux-sparse@vger.kernel.org

On Mon, Jan 07, 2019 at 05:54:27PM +0000, Will Deacon wrote:
> On Wed, Jan 02, 2019 at 03:57:54PM -0500, Michael S. Tsirkin wrote:
> > We don't really care whether the variable is in-register
> > or in-memory. Relax the constraint accordingly.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/linux/compiler.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 1ad367b4cd8d..6601d39e8c48 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -154,7 +154,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> >  #ifndef OPTIMIZER_HIDE_VAR
> >  /* Make the optimizer believe the variable can be manipulated arbitrarily. */
> >  #define OPTIMIZER_HIDE_VAR(var)						\
> > -	__asm__ ("" : "=r" (var) : "0" (var))
> > +	__asm__ ("" : "=rm" (var) : "0" (var))
> >  #endif
> 
> I think this can break for architectures with write-back addressing modes
> such as arm, where the "m" constraint is assumed to be evaluated precisely
> once in the asm block.
> 
> Will

Thanks, I'll drop this patch.
