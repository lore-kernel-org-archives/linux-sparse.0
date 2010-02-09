From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: RE: [PATCH 01/14] ARM: LPC32XX: Initial architecture header files
Date: Tue, 9 Feb 2010 12:10:39 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190902152FCF@mi8nycmail19.Mi8.com>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com><1265674295-23996-2-git-send-email-wellsk40@gmail.com><20100209093129.GA2284@pengutronix.de><20100209095934.GA11534@n2100.arm.linux.org.uk>
	<20100209165223.GA11113@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-class: urn:content-classes:message
In-Reply-To: <20100209165223.GA11113@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-sparse@vger.kernel.org, linux-arm-kernel@lists.infradead.org, wellsk40@gmail.com
List-Id: linux-sparse@vger.kernel.org

On Tuesday, February 09, 2010 9:52 AM, Uwe Kleine-K=F6nig wrote:
> [Added linux-sparse@vger.kernel.org to Cc:]
>
> On Tue, Feb 09, 2010 at 09:59:34AM +0000, Russell King - ARM Linux wrote:
>> On Tue, Feb 09, 2010 at 10:31:29AM +0100, Uwe Kleine-K=F6nig wrote:
>>>> +#define io_p2v(x)	((void __iomem *) (unsigned long) IO_ADDRESS(x))
>>> Is this cast to unsigned long needed?  AFAIK IO_ADDRESS(x) has
>>> type unsigned for x in { 0x0 ... 0xffffffff } (provided that int uses a
>>> 32 bit 2s-complement representation).  If unsigned long is really
>>> needed, maybe put it into the IO_ADDRESS macro?
>> =

>> int -> void __iomem * =3D sparse warning
>> unsigned long -> void __iomem * =3D no sparse warning
> Ah, OK, I see.  But IMHO it's a poor reason to add the cast.  Either
> the cast is necessary/recommended or sparse is wrong.  In the first case
> the reasoning shouldn't have to do with sparse, in the latter sparse
> should be fixed.
>
> I found the responsible code in sparse.  It reads:

[snip]

> so it seems to be explicitly allowed to make a pointer in any address
> space from an unsigned long, but not from a (signed or unsigned) int.
> Unfortunately there is no comment describing why unsigned long is
> allowed.
>
> Is this intended?  What is the preferred way to define iomem pointers?
>
> I found the following variants in the kernel[1]
>
>	#define ...	((void __iomem *)(unsigned long)0x12345678)
>	#define ...	((void __iomem __force *)0x12345678)
>	#define ...	((void __iomem *)0x12345678)
>
> where __iomem is defined as __attribute__((noderef, address_space(2)))
> for sparse.
>
> The first variant with the extra cast to unsigned long seems unnecessary
> long, the third results in the "cast adds address space to expression"
> warning.
>
> So what do you recommend?

Would this fix the third variant?

	#define ... ((void __iomem *)0x12345678UL)

Regards,
Hartley
