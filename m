From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH] linux/err.h: Provide an ERR_PTR_IO that returns an __iomem
 pointer
Date: Tue, 26 Nov 2013 18:17:30 -0800
Message-ID: <20131127021730.GA14138@leaf>
References: <001001ceb816$5d1aecc0$1750c640$%han@samsung.com>
 <20131125200256.GA7316@obsidianresearch.com>
 <001101ceea68$cb486220$61d92660$%han@samsung.com>
 <20131126180930.GC19852@obsidianresearch.com>
 <000101ceeb14$480fee80$d82fcb80$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:48129 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705Ab3K0CRn (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 26 Nov 2013 21:17:43 -0500
Content-Disposition: inline
In-Reply-To: <000101ceeb14$480fee80$d82fcb80$%han@samsung.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Christopher Li' <sparse@chrisli.org>, linux-sparse@vger.kernel.org, 'Joe Perches' <joe@perches.com>, 'Dan Carpenter' <dan.carpenter@oracle.com>, 'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>, 'Jason Cooper' <jason@lakedaemon.net>, 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>, 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org, 'Ezequiel Garcia' <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, 'Axel Lin' <axel.lin@ingics.com>, 'Julia Lawall' <julia.lawall@lip6.fr>

On Wed, Nov 27, 2013 at 10:59:18AM +0900, Jingoo Han wrote:
> On Wednesday, November 27, 2013 3:10 AM, Jason Gunthorpe wrote:
> > On Tue, Nov 26, 2013 at 02:31:44PM +0900, Jingoo Han wrote:
> > > Previously, I sent the patch in order to fix sparse warning as below:
> > > How about this?
> > >
> > > static void __iomem *mvebu_pcie_map_registers(struct platform_device *pdev,
> > > 			struct device_node *np, struct mvebu_pcie_port *port)
> > > {
> > > 	struct resource regs;
> > > 	int ret = 0;
> > >
> > > 	ret = of_address_to_resource(np, 0, &regs);
> > > 	if (ret)
> > > -		return ERR_PTR(ret);
> > > +		return (void __iomem *)ERR_PTR(ret);
> > 
> > You should probably ask the sparse folks for guidance 'git grep
> > iomem.*ERR_PTR' returns nothing, so this isn't an established pattern.
> > 
> > It seems like sparse should know that ERR_PTR functions can work with
> > any pointer no matter the type? IS_ERR_PTR will have the same problem
> > with implicitly dropping the iomem tag.
> 
> +cc Christopher Li, sparse mailing-list, Joe Perches, Dan Carpenter,
>      Axel Lin, Julia Lawall,
> 
> Hi All,
> 
> I have some questions about handling sparse warning.
> 
> Currently, the following sparse warning happens
> at Marvell Armada PCIe driver.
> 
> drivers/pci/host/pci-mvebu.c:743:31: warning: incorrect type in return expression (different address spaces)
> drivers/pci/host/pci-mvebu.c:743:31:    expected void [noderef] <asn:2>*
> drivers/pci/host/pci-mvebu.c:743:31:    got void *
> 
> mvebu_pcie_map_registers() returns ERR_PTR(ret),
> however ERR_PTR() returns (void *), not (void __iomem *).

Given that PTR_ERR, IS_ERR, and IS_ERR_OR_NULL currently accept any kind
of pointer (by using __force), it does make sense for ERR_PTR to return
any kind of pointer.  There's no built-in way to do this, but we could
add an ERR_PTR_iomem that has the appropriate return type.  Here's a
possible patch; please test in your particular use case and see if it
works for you.  (You can apply this patch from this mail via git am
--scissors.)

---8<---
From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH] linux/err.h: Provide an ERR_PTR_IO that returns an __iomem pointer

PTR_ERR, IS_ERR, and IS_ERR_OR_NULL already accept any type of pointer
by using __force; ERR_PTR should similarly be able to return any type of
pointer.  Provide an ERR_PTR_IO to return an error pointer in __iomem.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 include/linux/err.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/err.h b/include/linux/err.h
index 15f92e0..d64215b 100644
--- a/include/linux/err.h
+++ b/include/linux/err.h
@@ -24,6 +24,11 @@ static inline void * __must_check ERR_PTR(long error)
 	return (void *) error;
 }
 
+static inline __iomem void * __must_check ERR_PTR_IO(long error)
+{
+	return (__force __iomem void *) error;
+}
+
 static inline long __must_check PTR_ERR(__force const void *ptr)
 {
 	return (long) ptr;
-- 
1.8.4.4

