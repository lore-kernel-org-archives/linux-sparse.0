From: Joe Perches <joe@perches.com>
Subject: Re: PCI: mvebu: return NULL instead of ERR_PTR(ret)
Date: Tue, 26 Nov 2013 18:48:23 -0800
Message-ID: <1385520503.18487.32.camel@joe-AO722>
References: <001001ceb816$5d1aecc0$1750c640$%han@samsung.com>
	 <20131125200256.GA7316@obsidianresearch.com>
	 <001101ceea68$cb486220$61d92660$%han@samsung.com>
	 <20131126180930.GC19852@obsidianresearch.com>
	 <000101ceeb14$480fee80$d82fcb80$%han@samsung.com>
	 <1385519196.18487.25.camel@joe-AO722> <20131127023526.GA14732@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtprelay0086.hostedemail.com ([216.40.44.86]:60223 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751810Ab3K0Cs3 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Nov 2013 21:48:29 -0500
In-Reply-To: <20131127023526.GA14732@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Jingoo Han <jg1.han@samsung.com>, 'Christopher Li' <sparse@chrisli.org>, linux-sparse@vger.kernel.org, 'Dan Carpenter' <dan.carpenter@oracle.com>, 'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>, 'Jason Cooper' <jason@lakedaemon.net>, 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>, 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org, 'Ezequiel Garcia' <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, 'Axel Lin' <axel.lin@ingics.com>, 'Julia Lawall' <julia.lawall@lip6.fr>

On Tue, 2013-11-26 at 18:35 -0800, Josh Triplett wrote:
> On Tue, Nov 26, 2013 at 06:26:36PM -0800, Joe Perches wrote:
> > On Wed, 2013-11-27 at 10:59 +0900, Jingoo Han wrote:
> > []
> > > ./drivers/pci/host/pci-mvebu.c
> > > static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
> > > 		struct device_node *np, struct mvebu_pcie_port *port)
> > > {
> > > 	.....
> > > 
> > > 	ret = of_address_to_resource(np, 0, &regs);
> > > 	if (ret)
> > > -		return ERR_PTR(ret);
> > > +		return (void __iomem *)ERR_PTR(ret);
> > > 
> > > However, other engineers said that "(void __iomem *)ERR_PTR(ret)"
> > > is not a general pattern. I cannot find the proper method to resolve
> > > this sparse warning.
> > > 
> > > In this case, how can I resolve this sparse warning?
> > 
> > I think there's no problem using the cast.  It's not a
> > pattern because it's not been required before as function
> > returns have not previously been declared __iomem.
> > 
> > Or, perhaps the arm|hexagon specific #define below could
> > be made generic so it could be used.
> > 
> > arch/arm/include/asm/io.h:#define IOMEM(x)	((void __force __iomem *)(x))
> > 
> > 	return IOMEM(ERR_PTR(ret));
> > 
> > There aren't any current uses of return IOMEM(foo) either
> > though so the direct cast is probably more appropriate.
> 
> I don't think that #define is appropriate for any non-constant value;
> almost any instance of that __force cast applied to a variable would be
> better written by fixing types more appropriately.  I'd suggest
> updating that #define for both architectures to use BUILD_BUG_ON to
> assert __builtin_constant_p on its argument.

That's probably a good idea.

There are at least a couple things would likely need to be
fixed up if the #define were changed.

arch/arm/plat-omap/sram.c
drivers/clocksource/bcm_kona_timer.c

I've no issue with either a direct cast or your idea of
a new static inline like ERR_PTR_IO or IOMEM_ERR_PTR or
any other appropriate name.

