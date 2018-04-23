From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v2 1/4] tpm: Add explicit endianness cast
Date: Mon, 23 Apr 2018 12:06:32 +0200
Message-ID: <20180423100629.effueb6i7q3hmhu3@ltop.local>
References: <20180412101350.210547-1-tweek@google.com>
 <20180412101350.210547-2-tweek@google.com>
 <20180417030202.GA30624@ziepe.ca>
 <CA+zpnLdU=t6eOY9GOLAyiXkZBw=NueckiejHSexd8P7MKYuRww@mail.gmail.com>
 <20180417140013.GA2029@ziepe.ca>
 <CA+zpnLePcFJQURBNZEt=mRSRb9GUYR=1t9EQn82W0+311xKZ7w@mail.gmail.com>
 <20180420145740.GC30433@ziepe.ca>
 <CA+zpnLcSDTz99Z4fe4CGxH6RzTGvQCoGqQc4p_EMOj9=cuFQgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+zpnLcSDTz99Z4fe4CGxH6RzTGvQCoGqQc4p_EMOj9=cuFQgg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thiebaud Weksteen <tweek@google.com>
Cc: jgg@ziepe.ca, Christopher Li <sparse@chrisli.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Nayna Jain <nayna@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
List-Id: linux-sparse@vger.kernel.org

On Mon, Apr 23, 2018 at 09:22:06AM +0000, Thiebaud Weksteen wrote:
> On Fri, Apr 20, 2018 at 4:57 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > On Thu, Apr 19, 2018 at 01:09:12PM +0000, Thiebaud Weksteen wrote:
> > > On Tue, Apr 17, 2018 at 4:00 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > > On Tue, Apr 17, 2018 at 08:32:33AM +0000, Thiebaud Weksteen wrote:
> > > > > On Tue, Apr 17, 2018 at 5:02 AM Jason Gunthorpe <jgg@ziepe.ca>
> wrote:
> > > > >
> > > > > > On Thu, Apr 12, 2018 at 12:13:47PM +0200, Thiebaud Weksteen wrote:
> > > > > > > Signed-off-by: Thiebaud Weksteen <tweek@google.com>
> > > > > > >  drivers/char/tpm/tpm_eventlog_of.c | 4 ++--
> > > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/char/tpm/tpm_eventlog_of.c
> > > > > b/drivers/char/tpm/tpm_eventlog_of.c
> > > > > > > index 96fd5646f866..d74568d58a66 100644
> > > > > > > +++ b/drivers/char/tpm/tpm_eventlog_of.c
> > > > > > > @@ -56,8 +56,8 @@ int tpm_read_log_of(struct tpm_chip *chip)
> > > > > > >        * but physical tpm needs the conversion.
> > > > > > >        */
> > > > > > >       if (of_property_match_string(np, "compatible",
> "IBM,vtpm") <
> > > 0) {
> > > > > > > -             size = be32_to_cpup(sizep);
> > > > > > > -             base = be64_to_cpup(basep);
> > > > > > > +             size = be32_to_cpup((__be32 *)sizep);
> > > > > > > +             base = be64_to_cpup((__be64 *)basep);
> > > > >
> > > > > > Er, no.. change the definitions of sizep and basep to be __be
> > > > >
> > > > > > Jason
> > > > >
> > > > > Please read the comment before the condition. sizep and
> > > > > basep may contain either little endian or big endian and this block
> is
> > > used
> > > > > to adjust that. Let me know if there is a better way for handling
> this.
> > >
> > > > Well a cast like that will throw sparse warnings, you need __force at
> > > > least
> > >
> > > I don't think so. Since the variable is only defined as u32*, no
> specific
> > > warning is generated. I've used `make C=2 drivers/char/tpm/` with this
> > > patch applied and no new warning is being triggered.

Interesting.

> > I'm surprised to hear you say that..

Same for me.

> > Sparse is supposed to require force on all cast that change the
> > annotation, and there are many examples in the kernel that have force
> > in that case.


Yes, sparse is supposed to warn in such cases and the __force is there
to quiets the warning when it is known that the cast is in fact correct.

 
> +linux-sparse@vger.kernel.org and sparse@chrisli.org for a sanity check.
> 
> If you look at the man page of sparse, under the bitwise option, it states:
> "Sparse will warn on [...] any conversion of one restricted type into
> another, except via a cast that includes __attribute__((force)).". In our
> case, it is a conversion from unrestricted to restricted which does not
> fall in this category.

The man page is not very clear here. It must be understood in the context
where each use of '__bitwise' will create a new *distinct* type.
Given this and the normal type checking, sparse should warn
"on any conversion of one restricted type into another *or* between a
restricted and the corresponding plain/unrestricted type" (or consider
that an 'unrestricted type' is 'a restricted type with no restriction',
which is, I think, what was meant here).

The fact that sparse doesn't warn in your case is clearly a bug in
sparse's type checking.

Regards,
-- Luc Van Oostenryck
