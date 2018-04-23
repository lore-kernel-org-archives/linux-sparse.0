From: Thiebaud Weksteen <tweek@google.com>
Subject: Re: [PATCH v2 1/4] tpm: Add explicit endianness cast
Date: Mon, 23 Apr 2018 09:22:06 +0000
Message-ID: <CA+zpnLcSDTz99Z4fe4CGxH6RzTGvQCoGqQc4p_EMOj9=cuFQgg@mail.gmail.com>
References: <20180412101350.210547-1-tweek@google.com> <20180412101350.210547-2-tweek@google.com>
 <20180417030202.GA30624@ziepe.ca> <CA+zpnLdU=t6eOY9GOLAyiXkZBw=NueckiejHSexd8P7MKYuRww@mail.gmail.com>
 <20180417140013.GA2029@ziepe.ca> <CA+zpnLePcFJQURBNZEt=mRSRb9GUYR=1t9EQn82W0+311xKZ7w@mail.gmail.com>
 <20180420145740.GC30433@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180420145740.GC30433@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: jgg@ziepe.ca, Christopher Li <sparse@chrisli.org>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Nayna Jain <nayna@linux.vnet.ibm.com>, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Fri, Apr 20, 2018 at 4:57 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Thu, Apr 19, 2018 at 01:09:12PM +0000, Thiebaud Weksteen wrote:
> > On Tue, Apr 17, 2018 at 4:00 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > > On Tue, Apr 17, 2018 at 08:32:33AM +0000, Thiebaud Weksteen wrote:
> > > > On Tue, Apr 17, 2018 at 5:02 AM Jason Gunthorpe <jgg@ziepe.ca>
wrote:
> > > >
> > > > > On Thu, Apr 12, 2018 at 12:13:47PM +0200, Thiebaud Weksteen wrote:
> > > > > > Signed-off-by: Thiebaud Weksteen <tweek@google.com>
> > > > > >  drivers/char/tpm/tpm_eventlog_of.c | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/char/tpm/tpm_eventlog_of.c
> > > > b/drivers/char/tpm/tpm_eventlog_of.c
> > > > > > index 96fd5646f866..d74568d58a66 100644
> > > > > > +++ b/drivers/char/tpm/tpm_eventlog_of.c
> > > > > > @@ -56,8 +56,8 @@ int tpm_read_log_of(struct tpm_chip *chip)
> > > > > >        * but physical tpm needs the conversion.
> > > > > >        */
> > > > > >       if (of_property_match_string(np, "compatible",
"IBM,vtpm") <
> > 0) {
> > > > > > -             size = be32_to_cpup(sizep);
> > > > > > -             base = be64_to_cpup(basep);
> > > > > > +             size = be32_to_cpup((__be32 *)sizep);
> > > > > > +             base = be64_to_cpup((__be64 *)basep);
> > > >
> > > > > Er, no.. change the definitions of sizep and basep to be __be
> > > >
> > > > > Jason
> > > >
> > > > Please read the comment before the condition. sizep and
> > > > basep may contain either little endian or big endian and this block
is
> > used
> > > > to adjust that. Let me know if there is a better way for handling
this.
> >
> > > Well a cast like that will throw sparse warnings, you need __force at
> > > least
> >
> > I don't think so. Since the variable is only defined as u32*, no
specific
> > warning is generated. I've used `make C=2 drivers/char/tpm/` with this
> > patch applied and no new warning is being triggered.

> I'm surprised to hear you say that..

> Sparse is supposed to require force on all cast that change the
> annotation, and there are many examples in the kernel that have force
> in that case.

> Jason

+linux-sparse@vger.kernel.org and sparse@chrisli.org for a sanity check.

If you look at the man page of sparse, under the bitwise option, it states:
"Sparse will warn on [...] any conversion of one restricted type into
another, except via a cast that includes __attribute__((force)).". In our
case, it is a conversion from unrestricted to restricted which does not
fall in this category.
