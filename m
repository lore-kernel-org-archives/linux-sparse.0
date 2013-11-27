From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: PCI: mvebu: return NULL instead of ERR_PTR(ret)
Date: Wed, 27 Nov 2013 10:59:18 +0900
Message-ID: <000101ceeb14$480fee80$d82fcb80$%han@samsung.com>
References: <001001ceb816$5d1aecc0$1750c640$%han@samsung.com>
 <20131125200256.GA7316@obsidianresearch.com>
 <001101ceea68$cb486220$61d92660$%han@samsung.com>
 <20131126180930.GC19852@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <20131126180930.GC19852@obsidianresearch.com>
Content-language: ko
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: 'Christopher Li' <sparse@chrisli.org>, linux-sparse@vger.kernel.org, 'Joe Perches' <joe@perches.com>, 'Dan Carpenter' <dan.carpenter@oracle.com>
Cc: 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>, 'Axel Lin' <axel.lin@ingics.com>, 'Jason Cooper' <jason@lakedaemon.net>, linux-pci@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>, 'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>, 'Julia Lawall' <julia.lawall@lip6.fr>, 'Ezequiel Garcia' <ezequiel.garcia@free-electrons.com>, 'Bjorn Helgaas' <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-sparse@vger.kernel.org

On Wednesday, November 27, 2013 3:10 AM, Jason Gunthorpe wrote:
> On Tue, Nov 26, 2013 at 02:31:44PM +0900, Jingoo Han wrote:
> > Previously, I sent the patch in order to fix sparse warning as below:
> > How about this?
> >
> > static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
> > 			struct device_node *np, struct mvebu_pcie_port *port)
> > {
> > 	struct resource regs;
> > 	int ret = 0;
> >
> > 	ret = of_address_to_resource(np, 0, &regs);
> > 	if (ret)
> > -		return ERR_PTR(ret);
> > +		return (void __iomem *)ERR_PTR(ret);
> 
> You should probably ask the sparse folks for guidance 'git grep
> iomem.*ERR_PTR' returns nothing, so this isn't an established pattern.
> 
> It seems like sparse should know that ERR_PTR functions can work with
> any pointer no matter the type? IS_ERR_PTR will have the same problem
> with implicitly dropping the iomem tag.

+cc Christopher Li, sparse mailing-list, Joe Perches, Dan Carpenter,
     Axel Lin, Julia Lawall,

Hi All,

I have some questions about handling sparse warning.

Currently, the following sparse warning happens
at Marvell Armada PCIe driver.

drivers/pci/host/pci-mvebu.c:743:31: warning: incorrect type in return expression (different address spaces)
drivers/pci/host/pci-mvebu.c:743:31:    expected void [noderef] <asn:2>*
drivers/pci/host/pci-mvebu.c:743:31:    got void *

mvebu_pcie_map_registers() returns ERR_PTR(ret),
however ERR_PTR() returns (void *), not (void __iomem *).

./drivers/pci/host/pci-mvebu.c
static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
		struct device_node *np, struct mvebu_pcie_port *port)
{
	struct resource regs;
	int ret = 0;

	ret = of_address_to_resource(np, 0, &regs);
	if (ret)
		return ERR_PTR(ret);

	return devm_ioremap_resource(&pdev->dev, &regs);
}
./include/linux/err.h
static inline void * __must_check ERR_PTR(long error)
{
	return (void *) error;
}


Previously, I submitted the following patch, that adds
(void __iomem *) cast.

./drivers/pci/host/pci-mvebu.c
static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
		struct device_node *np, struct mvebu_pcie_port *port)
{
	.....

	ret = of_address_to_resource(np, 0, &regs);
	if (ret)
-		return ERR_PTR(ret);
+		return (void __iomem *)ERR_PTR(ret);

However, other engineers said that "(void __iomem *)ERR_PTR(ret)"
is not a general pattern. I cannot find the proper method to resolve
this sparse warning.

In this case, how can I resolve this sparse warning?

Then, how about the following?

--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -740,7 +740,7 @@ static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,

	ret = of_address_to_resource(np, 0, &regs);
	if (ret)
-		return ERR_PTR(ret);
+		return NULL;

	return devm_ioremap_resource(&pdev->dev, &regs);
 }
@@ -939,7 +939,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
		continue;

		port->base = mvebu_pcie_map_registers(pdev, child, port);
-		if (IS_ERR(port->base)) {
+		if (IS_ERR_OR_NULL(port->base)) {
			dev_err(&pdev->dev, "PCIe%d.%d: cannot map registers\n",
				port->port, port->lane);
			port->base = NULL;

Thank you for reading this. :-)

Best regards,
Jingoo Han
