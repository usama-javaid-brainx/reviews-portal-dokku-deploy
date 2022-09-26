// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import PlacesController from "./places_controller.js"
application.register("places", PlacesController)

import TogglePasswordController from "./toggle_password_controller.js";
application.register("toggle-password", TogglePasswordController)

import TagsController from "./tags_controller.js"
application.register("tags", TagsController)

import MealsController from "./meals_controller.js"
application.register("meals", MealsController)

import DollarPriceRangeController from "./dollar_price_range_controller.js"
application.register("dollar-price-range", DollarPriceRangeController)

import CategoryController from "./category_controller.js"
application.register("category", CategoryController)

import FilterController from "./filter_controller.js"
application.register("filter", FilterController)

import FavouriteController from "./favourite_controller.js"
application.register("favourite", FavouriteController)

import UserValidationController from "./user_validation_controller.js"
application.register("user-validation", UserValidationController)

import PhotosController from "./photos_controller.js"
application.register("photos", PhotosController)

import SortableImagesController from "./sortable_images_controller.js"
application.register("sortable-images", SortableImagesController)

import CategoryReorderController from "./category_reorder_controller.js"
application.register("category-reorder", CategoryReorderController)

import UserValidationController from "./user_validation_controller.js"
application.register("user-validation", UserValidationController)

import GuestController from "./guest_controller.js"
application.register("guest", GuestController)
