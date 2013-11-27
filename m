From: Joe Perches <joe@perches.com>
Subject: Re: PCI: mvebu: return NULL instead of ERR_PTR(ret)
Date: Tue, 26 Nov 2013 18:26:36 -0800
Message-ID: <1385519196.18487.25.camel@joe-AO722>
References: <001001ceb816$5d1aecc0$1750c640$%han@samsung.com>
	 <20131125200256.GA7316@obsidianresearch.com>
	 <001101ceea68$cb486220$61d92660$%han@samsung.com>
	 <20131126180930.GC19852@obsidianresearch.com>
	 <000101ceeb14$480fee80$d82fcb80$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtprelay0218.hostedemail.com ([216.40.44.218]:46125 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752467Ab3K0C0m (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Nov 2013 21:26:42 -0500
In-Reply-To: <000101ceeb14$480fee80$d82fcb80$%han@samsung.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Christopher Li' <sparse@chrisli.org>, linux-sparse@vger.kernel.org, 'Dan Carpenter' <dan.carpenter@oracle.com>, 'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>, 'Jason Cooper' <jason@lakedaemon.net>, 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>, 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org, 'Ezequiel Garcia' <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, 'Axel Lin' <axel.lin@ingics.com>, 'Julia Lawall' <julia.lawall@lip6.fr>

On Wed, 2013-11-27 at 10:59 +0900, Jingoo Han wrote:
[]
> ./drivers/pci/host/pci-mvebu.c
> static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
> 		struct device_node *np, struct mvebu_pcie_port *port)
> {
> 	.....
> 
> 	ret = of_address_to_resource(np, 0, &regs);
> 	if (ret)
> -		return ERR_PTR(ret);
> +		return (void __iomem *)ERR_PTR(ret);
> 
> However, other engineers said that "(void __iomem *)ERR_PTR(ret)"
> is not a general pattern. I cannot find the proper method to resolve
> this sparse warning.
> 
> In this case, how can I resolve this sparse warning?

I think there's no problem using the cast.  It's not a
pattern because it's not been required before as function
returns have not previously been declared __iomem.

Or, perhaps the arm|hexagon specific #define below could
be made generic so it could be used.

arch/arm/include/asm/io.h:#define IOMEM(x)	((void __force __iomem *)(x))

	return IOMEM(ERR_PTR(ret));

There aren't any current uses of return IOMEM(foo) either
though so the direct cast is probably more appropriate.


