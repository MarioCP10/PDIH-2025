/**
 * @file    hello.c
 * @author  Mario Casas
 * @date    26 March 2025
 * @version 0.1
 * @brief   An introductory loadable kernel module (LKM).
 * @see     http://www.derekmolloy.ie/ for a full description
 */

#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>

MODULE_LICENSE("GPL");                ///< The license type
MODULE_AUTHOR("Mario Casas Pérez");        ///< The author
MODULE_DESCRIPTION("Esto es un módulo sencillo que estoy haciendo para el S4 de PDIH."); ///< Description
MODULE_VERSION("0.1");                ///< The version of the module

static char *name = "profesor";
static char *name2 = "encantado de conocerte";
module_param(name, charp, S_IRUGO);
MODULE_PARM_DESC(name, "The name to display in log");

/** @brief The LKM initialization function
 *  @return returns 0 if successful
 */
static int __init helloBBB_init(void) {
    printk(KERN_INFO "EBB: Hola %s, te saludo desde BBB LKM!\n", name);
    return 0;
}

/** @brief The LKM cleanup function
 */
static void __exit helloBBB_exit(void) {
    printk(KERN_INFO "EBB: Adios, %s, me despido desde BBB LKM!\n", name2);
}

/** @brief Identify the initialization function at insertion time and the cleanup function */
module_init(helloBBB_init);
module_exit(helloBBB_exit);
