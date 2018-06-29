From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v4 00/17] khwasan: kernel hardware assisted address
 sanitizer
Date: Fri, 29 Jun 2018 16:42:57 +0300
Message-ID: <20180629134257.ci5ninozkh2ni6wd@mwanda>
References: <cover.1530018818.git.andreyknvl@google.com>
 <20180628105057.GA26019@e103592.cambridge.arm.com>
 <CAAeHK+w0T43+h3xqU4a-qutxd-qiEhsvk0eaZpmAn-T0hpaLZQ@mail.gmail.com>
 <20180629110419.GC26019@e103592.cambridge.arm.com>
 <20180629112613.7i4xesjyxolc63gu@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180629112613.7i4xesjyxolc63gu@ltop.local>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Kate Stewart <kstewart@linuxfoundation.org>, linux-doc@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Paul Lawrence <paullawrence@google.com>, Linux Memory Management List <linux-mm@kvack.org>, Alexander Potapenko <glider@google.com>, Chintan Pandya <cpandya@codeaurora.org>, Christoph Lameter <cl@linux.com>, smatch@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Jacob Bramley <Jacob.Bramley@arm.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Mark Brand <markbrand@google.com>, kasan-dev <kasan-dev@googlegroups.com>, linux-sparse@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Martin <Dave.Martin@arm.com>, Evgeniy
List-Id: linux-sparse@vger.kernel.org

On Fri, Jun 29, 2018 at 01:26:14PM +0200, Luc Van Oostenryck wrote:
> On Fri, Jun 29, 2018 at 12:04:22PM +0100, Dave Martin wrote:
> > 
> > Can sparse be hacked to identify pointer subtractions where the pointers
> > are cannot be statically proved to point into the same allocation?
> 
> sparse only see the (deatils of) the function it analyses and all
> visible declarations, nothing more.
> 
> It would be more a job for smatch which do global analysis.
> But to identify such subtractions yu must already have a (good)
> pointer alias analysis which I don't think smatch do (but I can
> be wrong, Dan & smatch's ml added in CC).

That would be hard to manage.  Maybe in a year from now...

Pointer math errors tend to get caught pretty quick because they're on
the success path so I don't imagine there are huge numbers of bugs.

regards,
dan carpenter
