From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] include/linux/hugetlb.h: Convert to use vm_fault_t
Date: Tue, 19 Mar 2019 18:51:08 +0100
Message-ID: <20190319175107.oxwjf72hpcqqmo3l@ltop.local>
References: <20190318162604.GA31553@jordon-HP-15-Notebook-PC>
 <20190319032022.GR19508@bombadil.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190319032022.GR19508@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: Souptick Joarder <jrdr.linux@gmail.com>, akpm@linux-foundation.org, mike.kravetz@oracle.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

On Mon, Mar 18, 2019 at 08:20:22PM -0700, Matthew Wilcox wrote:
> On Mon, Mar 18, 2019 at 09:56:05PM +0530, Souptick Joarder wrote:
> > >> mm/memory.c:3968:21: sparse: incorrect type in assignment (different
> > >> base types) @@    expected restricted vm_fault_t [usertype] ret @@
> > >> got e] ret @@
> >    mm/memory.c:3968:21:    expected restricted vm_fault_t [usertype] ret
> >    mm/memory.c:3968:21:    got int
> 
> I think this may be a sparse bug.
> 
> Compare:
> 
> +++ b/mm/memory.c
> @@ -3964,6 +3964,9 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>         if (flags & FAULT_FLAG_USER)
>                 mem_cgroup_enter_user_fault();
>  
> +       ret = 0;
> +       ret = ({ BUG(); 0; });
> +       ret = 1;
>         if (unlikely(is_vm_hugetlb_page(vma)))
>                 ret = hugetlb_fault(vma->vm_mm, vma, address, flags);
>         else
> 
> ../mm/memory.c:3968:13: sparse: warning: incorrect type in assignment (different base types)
> ../mm/memory.c:3968:13: sparse:    expected restricted vm_fault_t [assigned] [usertype] ret
> ../mm/memory.c:3968:13: sparse:    got int
> ../mm/memory.c:3969:13: sparse: warning: incorrect type in assignment (different base types)
> ../mm/memory.c:3969:13: sparse:    expected restricted vm_fault_t [assigned] [usertype] ret
> ../mm/memory.c:3969:13: sparse:    got int
> 
> vm_fault_t is __bitwise:
> 
> include/linux/mm_types.h:typedef __bitwise unsigned int vm_fault_t;
> 
> so simply assigning 0 to ret should work (and does on line 3967), but
> sparse doesn't seem to like it as part of a ({ .. }) expression.

This is the expected behaviour. The constant 0 is magic regarding
bitwise types but ({ ...; 0; }) is not, it is just an ordinary expression
of type 'int'.

So, IMHO, Souptick's patch is the right thing to do.


Best regards,
-- Luc Van Oostenryck
